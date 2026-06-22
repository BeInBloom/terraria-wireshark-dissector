local M = {}

---@class TerrariaVector2
---@field x number
---@field y number

---@class TerrariaColor
---@field r integer
---@field g integer
---@field b integer

---@class TerrariaNetworkText
---@field mode integer
---@field text string
---@field substitutions TerrariaNetworkText[]
---@field mode_range TvbRange
---@field text_range TvbRange
---@field substitution_count integer
---@field substitution_count_range? TvbRange
---@field substitution_ranges TvbRange[]

---@class PayloadReader
---@field ctx PacketContext
---@field cursor integer
local PayloadReader = {}
PayloadReader.__index = PayloadReader

---@param ctx PacketContext
---@return PayloadReader
function M.new(ctx)
	return setmetatable({
		ctx = ctx,
		cursor = 0,
	}, PayloadReader)
end

---@return integer
function PayloadReader:remaining()
	return self.ctx.payload_len - self.cursor
end

---@param len integer
---@return TvbRange
function PayloadReader:range(len)
	assert(self:remaining() >= len, "payload reader out of bounds")
	local range = self.ctx:payload_subrange(self.cursor, len)
	self.cursor = self.cursor + len
	return range
end

---@return integer
---@return TvbRange
function PayloadReader:uint8()
	local range = self:range(1)
	return range:uint(), range
end

---@return integer
---@return TvbRange
function PayloadReader:uint16_le()
	local range = self:range(2)
	return range:le_uint(), range
end

---@return integer
---@return TvbRange
function PayloadReader:int16_le()
	local range = self:range(2)
	return range:le_int(), range
end

---@return integer
function PayloadReader:read_7bit_encoded_int()
	local res = 0
	local shift = 0

	for _ = 1, 5 do
		local byte = self:uint8()

		res = res | ((byte & 0x7F) << shift)
		if (byte & 0x80) == 0 then
			return res
		end

		shift = shift + 7
	end

	error("invalid 7-bit encoded int")
end

---@return string
---@return TvbRange
function PayloadReader:string()
	local len = self:read_7bit_encoded_int()
	local range = self:range(len)
	return range:string(encoding.ENC_UTF_8), range
end

---@return boolean
---@return TvbRange
function PayloadReader:bool()
	local value, range = self:uint8()
	return value ~= 0, range
end

---@return integer
---@return TvbRange
function PayloadReader:int32_le()
	local range = self:range(4)
	return range:le_int(), range
end

---@return integer
---@return TvbRange
function PayloadReader:uint32_le()
	local range = self:range(4)
	return range:le_uint(), range
end

---@return UInt64
---@return TvbRange
function PayloadReader:uint64_le()
	local range = self:range(8)
	return range:le_uint64(), range
end

---@return integer
---@return TvbRange
function PayloadReader:sbyte()
	local range = self:range(1)
	return range:int(), range
end

---@return number
---@return TvbRange
function PayloadReader:single_le()
	local range = self:range(4)
	return range:le_float(), range
end

---@param len integer
---@return string
---@return TvbRange
function PayloadReader:bytes(len)
	local range = self:range(len)
	return range:raw(), range
end

---@param start integer
---@return TvbRange
function PayloadReader:range_from(start)
	assert(start >= 0, "payload range start must be non-negative")
	assert(start <= self.cursor, "payload range start is after cursor")
	return self.ctx:payload_subrange(start, self.cursor - start)
end

---@return TerrariaVector2
---@return TvbRange
function PayloadReader:vector2()
	local start = self.cursor

	local x = self:single_le()
	local y = self:single_le()

	return {
		x = x,
		y = y,
	}, self:range_from(start)
end

---@return TerrariaColor
---@return TvbRange
function PayloadReader:color()
	local start = self.cursor

	local r = self:uint8()
	local g = self:uint8()
	local b = self:uint8()

	return {
		r = r,
		g = g,
		b = b,
	}, self:range_from(start)
end

---@return TerrariaNetworkText
---@return TvbRange
function PayloadReader:network_text()
	local start = self.cursor

	local mode, mode_range = self:uint8()
	local text, text_range = self:string()

	local substitutions = {}
	local substitution_ranges = {}
	local substitution_count = 0
	local substitution_count_range = nil

	if mode ~= 0 then
		substitution_count, substitution_count_range = self:uint8()

		for i = 1, substitution_count do
			-- WARNING: Malformed payloads with deeply nested NetworkText may overflow the Lua stack.
			local substitution, substitution_range = self:network_text()
			substitutions[i] = substitution
			substitution_ranges[i] = substitution_range
		end
	end

	return {
		mode = mode,
		text = text,
		substitutions = substitutions,
		mode_range = mode_range,
		text_range = text_range,
		substitution_count = substitution_count,
		substitution_count_range = substitution_count_range,
		substitution_ranges = substitution_ranges,
	}, self:range_from(start)
end

return M
