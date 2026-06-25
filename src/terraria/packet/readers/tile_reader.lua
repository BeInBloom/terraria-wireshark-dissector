local M = {}

---@alias TileFrameImportant fun(tile_type: integer): boolean

---@class TileReader
---@field reader ByteReader
---@field is_frame_important TileFrameImportant
local TileReader = {}
TileReader.__index = TileReader

---@param reader ByteReader
---@param is_frame_important TileFrameImportant
---@return TileReader
function M.new(reader, is_frame_important)
	assert(type(is_frame_important) == "function", "tile frame predicate is required")

	return setmetatable({
		reader = reader,
		is_frame_important = is_frame_important,
	}, TileReader)
end

---@param tile TerrariaTile
function TileReader:decode_flags1(tile)
	local flags = tile.flags1
	tile.active = (flags & 0x01) ~= 0
	tile.lighted = (flags & 0x02) ~= 0
	tile.has_wall = (flags & 0x04) ~= 0
	tile.has_liquid = (flags & 0x08) ~= 0
	tile.wire1 = (flags & 0x10) ~= 0
	tile.half_brick = (flags & 0x20) ~= 0
	tile.actuator = (flags & 0x40) ~= 0
	tile.inactive = (flags & 0x80) ~= 0
end

---@param tile TerrariaTile
function TileReader:decode_flags2(tile)
	local flags = tile.flags2
	tile.wire2 = (flags & 0x01) ~= 0
	tile.wire3 = (flags & 0x02) ~= 0
	tile.wire4 = (flags & 0x80) ~= 0
	tile.slope = (flags >> 4) & 0x07
end

---@return TerrariaTile
function TileReader:read_flags()
	local flags1, flags1_range = self.reader:uint8()
	local flags2, flags2_range = self.reader:uint8()
	local tile = {
		flags1 = flags1,
		flags2 = flags2,
		flags1_range = flags1_range,
		flags2_range = flags2_range,
	}

	self:decode_flags1(tile)
	self:decode_flags2(tile)
	return tile
end

---@param tile TerrariaTile
function TileReader:read_colors(tile)
	if (tile.flags2 & 0x04) ~= 0 then
		tile.color, tile.color_range = self.reader:uint8()
	end

	if (tile.flags2 & 0x08) ~= 0 then
		tile.wall_color, tile.wall_color_range = self.reader:uint8()
	end
end

---@param tile TerrariaTile
function TileReader:read_active_data(tile)
	if not tile.active then
		return
	end

	tile.type, tile.type_range = self.reader:uint16_le()
	if self.is_frame_important(tile.type) then
		tile.frame_x, tile.frame_x_range = self.reader:int16_le()
		tile.frame_y, tile.frame_y_range = self.reader:int16_le()
	end
end

---@param tile TerrariaTile
function TileReader:read_wall(tile)
	if tile.has_wall then
		tile.wall, tile.wall_range = self.reader:uint8()
	end
end

---@param tile TerrariaTile
function TileReader:read_liquid(tile)
	if not tile.has_liquid then
		return
	end

	tile.liquid, tile.liquid_range = self.reader:uint8()
	tile.liquid_type, tile.liquid_type_range = self.reader:uint8()
end

---@return TerrariaTile
---@return TvbRange
function TileReader:read()
	local start = self.reader:position()
	local tile = self:read_flags()

	self:read_colors(tile)
	self:read_active_data(tile)
	self:read_wall(tile)
	self:read_liquid(tile)

	return tile, self.reader:range_from(start)
end

return M
