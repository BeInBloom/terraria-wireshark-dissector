local tile_entity_id = ProtoField.int32(
	"terraria.request_tile_entity_interaction.tile_entity_id",
	"Tile Entity ID",
	base.DEC
)
local player_id = ProtoField.uint8("terraria.request_tile_entity_interaction.player_id", "Player ID", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int32_le(tile_entity_id)
	payload:uint8(player_id)
end

return {
	id = 122,
	build = build,
	fields = {
		tile_entity_id,
		player_id,
	},
}
