local string_reader = require("terraria.packet.readers.string_reader")

local M = {}

---@class ChestReader
---@field reader ByteReader
---@field strings StringReader
local ChestReader = {}
ChestReader.__index = ChestReader

---@param reader ByteReader
---@return ChestReader
function M.new(reader)
	return setmetatable({
		reader = reader,
		strings = string_reader.new(reader),
	}, ChestReader)
end

---@return TerrariaChest
---@return TvbRange
function ChestReader:read()
	local start = self.reader:position()
	local id, id_range = self.reader:int16_le()
	local x, x_range = self.reader:int16_le()
	local y, y_range = self.reader:int16_le()
	local name, name_range = self.strings:read()

	return {
		id = id,
		x = x,
		y = y,
		name = name,
		id_range = id_range,
		x_range = x_range,
		y_range = y_range,
		name_range = name_range,
	}, self.reader:range_from(start)
end

return M
