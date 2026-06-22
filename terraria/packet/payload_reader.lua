local M = {}

---@class TerrariaVector2
---@field x number
---@field y number

---@class TerrariaColor
---@field r integer
---@field g integer
---@field b integer

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
function PayloadReader:range_from_start(start)
	return self.ctx:payload_subrange(start, self.cursor - start)
end

---@return TerrariaVector2
---@return TvbRange
function PayloadReader:vector2()
	local start = self.cursor

	local x = self:single_le()
	local y = self:single_le()

	local range = self:range_from_start(start)

	return {
		x = x,
		y = y,
	}, range
end

---@return TerrariaColor
---@return TvbRange
function PayloadReader:color()
	local start = self.cursor

	local r = self:uint8()
	local g = self:uint8()
	local b = self:uint8()

	local range = self:range_from_start(start)

	return {
		r = r,
		g = g,
		b = b,
	}, range
end

return M
