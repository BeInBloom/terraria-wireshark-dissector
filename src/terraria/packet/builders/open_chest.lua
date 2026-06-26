local tile_x = ProtoField.int16("terraria.open_chest.tile_x", "Tile X", base.DEC)
local tile_y = ProtoField.int16("terraria.open_chest.tile_y", "Tile Y", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(tile_x)
	payload:int16_le(tile_y)
end

return {
	id = 31,
	build = build,
	fields = {
		tile_x,
		tile_y,
	},
}
