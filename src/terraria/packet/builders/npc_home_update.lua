local npc_id = ProtoField.int16("terraria.npc_home_update.npc_id", "NPC ID", base.DEC)
local home_tile_x = ProtoField.int16(
	"terraria.npc_home_update.home_tile_x",
	"Home Tile X",
	base.DEC
)
local home_tile_y = ProtoField.int16(
	"terraria.npc_home_update.home_tile_y",
	"Home Tile Y",
	base.DEC
)
local homeless = ProtoField.uint8("terraria.npc_home_update.homeless", "Homeless", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(npc_id)
	payload:int16_le(home_tile_x)
	payload:int16_le(home_tile_y)
	payload:uint8(homeless)
end

return {
	id = 60,
	build = build,
	fields = {
		npc_id,
		home_tile_x,
		home_tile_y,
		homeless,
	},
}
