local fields = {
	encoded_size = ProtoField.uint16(
		"terraria.send_tile_square.encoded_size",
		"Encoded Size",
		base.HEX
	),
	size = ProtoField.uint16("terraria.send_tile_square.size", "Size", base.DEC),
	tile_change_type = ProtoField.uint8(
		"terraria.send_tile_square.tile_change_type",
		"Tile Change Type",
		base.DEC
	),
	tile_x = ProtoField.int16("terraria.send_tile_square.tile_x", "Tile X", base.DEC),
	tile_y = ProtoField.int16("terraria.send_tile_square.tile_y", "Tile Y", base.DEC),
	tiles = ProtoField.bytes("terraria.send_tile_square.tiles", "Tiles"),
}

---@param payload PayloadReader
local function build(payload)
	payload:send_tile_square(fields)
end

return {
	id = 20,
	build = build,
	fields = {
		fields.encoded_size,
		fields.size,
		fields.tile_change_type,
		fields.tile_x,
		fields.tile_y,
		fields.tiles,
	},
}
