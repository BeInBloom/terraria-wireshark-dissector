local player_id = ProtoField.uint8("terraria.set_active_npc.player_id", "Player ID", base.DEC)
local npc_talk_target = ProtoField.int16(
	"terraria.set_active_npc.npc_talk_target",
	"NPC Talk Target",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:int16_le(npc_talk_target)
end

return {
	id = 40,
	build = build,
	fields = {
		player_id,
		npc_talk_target,
	},
}
