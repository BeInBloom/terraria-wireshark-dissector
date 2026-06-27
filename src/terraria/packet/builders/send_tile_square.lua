local send_tile_square_reader = require("terraria.packet.readers.send_tile_square_reader")

local fields = {
	root = ProtoField.bytes("terraria.send_tile_square.root", "Send Tile Square"),
	header = ProtoField.bytes("terraria.send_tile_square.header", "Header"),
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

---@param tree TreeItem
---@param fields table
---@param value TerrariaSendTileSquare
---@return nil
local function build_header(tree, fields, value)
	local header = tree:add(fields.header, value.header_range)

	header:add_le(fields.encoded_size, value.encoded_size_range, value.encoded_size)
	header:add_le(fields.size, value.encoded_size_range, value.size)

	if value.tile_change_type_range then
		header:add(
			fields.tile_change_type,
			value.tile_change_type_range,
			value.tile_change_type
		)
	end

	header:add_le(fields.tile_x, value.tile_x_range, value.tile_x)
	header:add_le(fields.tile_y, value.tile_y_range, value.tile_y)
end

---@param payload PayloadReader
---@return nil
local function build(payload)
	local value, range = send_tile_square_reader.new(payload.reader):read()
	local tree = payload.tree:add(fields.root, range)

	build_header(tree, fields, value)

	if value.tiles_range then
		tree:add(fields.tiles, value.tiles_range)
	end
end

return {
	id = 20,
	build = build,
	fields = {
		fields.root,
		fields.header,
		fields.encoded_size,
		fields.size,
		fields.tile_change_type,
		fields.tile_x,
		fields.tile_y,
		fields.tiles,
	},
}
