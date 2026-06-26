local M = {}

local HAS_TILE_CHANGE_TYPE = 0x8000
local SIZE_MASK = 0x7fff

---@class SendTileSquareReader
---@field reader ByteReader
local SendTileSquareReader = {}
SendTileSquareReader.__index = SendTileSquareReader

---@param reader ByteReader
---@return SendTileSquareReader
function M.new(reader)
	return setmetatable({
		reader = reader,
	}, SendTileSquareReader)
end

---@param value TerrariaSendTileSquare
function SendTileSquareReader:read_tile_change_type(value)
	if (value.encoded_size & HAS_TILE_CHANGE_TYPE) == 0 then
		return
	end

	value.tile_change_type, value.tile_change_type_range = self.reader:uint8()
end

---@param value TerrariaSendTileSquare
function SendTileSquareReader:read_tiles(value)
	if self.reader:remaining() == 0 then
		return
	end

	value.tiles, value.tiles_range = self.reader:bytes(self.reader:remaining())
end

---@return TerrariaSendTileSquare
---@return TvbRange
function SendTileSquareReader:read()
	local start = self.reader:position()
	local value = {}

	value.encoded_size, value.encoded_size_range = self.reader:uint16_le()
	value.size = value.encoded_size & SIZE_MASK
	self:read_tile_change_type(value)
	value.tile_x, value.tile_x_range = self.reader:int16_le()
	value.tile_y, value.tile_y_range = self.reader:int16_le()
	self:read_tiles(value)

	return value, self.reader:range_from(start)
end

return M
