local M = {}

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

function PayloadReader:uint8()
	local range = self:range(1)
	return range:uint(), range
end

function PayloadReader:uint16_le()
	local range = self:range(2)
	return range:le_uint(), range
end

function PayloadReader:int16_le()
	local range = self:range(2)
	return range:le_int(), range
end

---@return integer
function PayloadReader:read_7bit_encoded_int()
	local res = 0
	local shift = 0

	while true do
		local byte = self:uint8()

		res = res | ((byte & 0x7F) << shift)
		if (byte & 0x80) then
			return res
		end

		shift = shift + 7
	end
end

---@return string
---@return TvbRange
function PayloadReader:string()
	local len = self:read_7bit_encoded_int()
	local range = self:range(len)
	return range:string(encoding.ENC_UTF_8), range
end

return M
