local M = {}

---@class ColorReader
---@field reader ByteReader
local ColorReader = {}
ColorReader.__index = ColorReader

---@param reader ByteReader
---@return ColorReader
function M.new(reader)
	return setmetatable({
		reader = reader,
	}, ColorReader)
end

---@return TerrariaColor
---@return TvbRange
function ColorReader:read()
	local start = self.reader:position()

	local r = self.reader:uint8()
	local g = self.reader:uint8()
	local b = self.reader:uint8()

	return {
		r = r,
		g = g,
		b = b,
	}, self.reader:range_from(start)
end

return M
