local x = ProtoField.int16("terraria.place_tile_entity.x", "X", base.DEC)
local y = ProtoField.int16("terraria.place_tile_entity.y", "Y", base.DEC)
local tile_entity_type = ProtoField.uint8(
	"terraria.place_tile_entity.tile_entity_type",
	"Tile Entity Type",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(x)
	payload:int16_le(y)
	payload:uint8(tile_entity_type)
end

return {
	id = 87,
	build = build,
	fields = {
		x,
		y,
		tile_entity_type,
	},
}
