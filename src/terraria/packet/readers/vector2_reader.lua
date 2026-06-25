local M = {}

---@class Vector2Reader
---@field reader ByteReader
local Vector2Reader = {}
Vector2Reader.__index = Vector2Reader

---@param reader ByteReader
---@return Vector2Reader
function M.new(reader)
	return setmetatable({
		reader = reader,
	}, Vector2Reader)
end

---@return TerrariaVector2
---@return TvbRange
function Vector2Reader:read()
	local start = self.reader:position()

	local x = self.reader:single_le()
	local y = self.reader:single_le()

	return {
		x = x,
		y = y,
	}, self.reader:range_from(start)
end

return M
