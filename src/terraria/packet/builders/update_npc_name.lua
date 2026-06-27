local npc_id = ProtoField.int16("terraria.update_npc_name.npc_id", "NPC ID", base.DEC)
local name = ProtoField.string("terraria.update_npc_name.name", "Name")
local town_npc_variation_index = ProtoField.int32(
	"terraria.update_npc_name.town_npc_variation_index",
	"Town NPC Variation Index",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(npc_id)
	payload:string(name)
	payload:int32_le(town_npc_variation_index)
end

return {
	id = 56,
	build = build,
	fields = {
		npc_id,
		name,
		town_npc_variation_index,
	},
}
