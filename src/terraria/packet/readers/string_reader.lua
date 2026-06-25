local M = {}

---@class StringReader
---@field reader ByteReader
local StringReader = {}
StringReader.__index = StringReader

---@param reader ByteReader
---@return StringReader
function M.new(reader)
	return setmetatable({
		reader = reader,
	}, StringReader)
end

---@return integer
function StringReader:read_length()
	local result = 0
	local shift = 0

	for _ = 1, 5 do
		local byte = self.reader:uint8()
		result = result | ((byte & 0x7F) << shift)
		if (byte & 0x80) == 0 then
			return result
		end
		shift = shift + 7
	end

	error("invalid 7-bit encoded string length")
end

---@return string
---@return TvbRange
function StringReader:read()
	local start = self.reader:position()
	local len = self:read_length()
	local range = self.reader:range(len)
	return range:string(ENC_UTF_8), self.reader:range_from(start)
end

return M
