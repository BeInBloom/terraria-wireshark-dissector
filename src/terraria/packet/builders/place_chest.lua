local action = ProtoField.uint8("terraria.place_chest.action", "Action", base.DEC)
local tile_x = ProtoField.int16("terraria.place_chest.tile_x", "Tile X", base.DEC)
local tile_y = ProtoField.int16("terraria.place_chest.tile_y", "Tile Y", base.DEC)
local style = ProtoField.int16("terraria.place_chest.style", "Style", base.DEC)
local chest_id_to_destroy = ProtoField.int16(
	"terraria.place_chest.chest_id_to_destroy",
	"Chest ID to Destroy",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(action)
	payload:int16_le(tile_x)
	payload:int16_le(tile_y)
	payload:int16_le(style)
	payload:int16_le(chest_id_to_destroy)
end

return {
	id = 34,
	build = build,
	fields = {
		action,
		tile_x,
		tile_y,
		style,
		chest_id_to_destroy,
	},
}
