local extra_reader = require("terraria.packet.readers.tile_entity_extra_reader")

local M = {}

---@class TileEntityReader
---@field reader ByteReader
local TileEntityReader = {}
TileEntityReader.__index = TileEntityReader

---@param reader ByteReader
---@return TileEntityReader
function M.new(reader)
	return setmetatable({
		reader = reader,
	}, TileEntityReader)
end

---@return TerrariaTileEntity
---@return TvbRange
function TileEntityReader:read()
	local start = self.reader:position()
	local entity_type, type_range = self.reader:uint8()
	local id, id_range = self.reader:int32_le()
	local x, x_range = self.reader:int16_le()
	local y, y_range = self.reader:int16_le()
	local extra_data, extra_range = extra_reader.new(self.reader, entity_type):read()

	return {
		type = entity_type,
		id = id,
		x = x,
		y = y,
		extra_data = extra_data,
		type_range = type_range,
		id_range = id_range,
		x_range = x_range,
		y_range = y_range,
		extra_data_range = extra_range,
	}, self.reader:range_from(start)
end

return M
