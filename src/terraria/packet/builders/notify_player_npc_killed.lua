local npc_id = ProtoField.int16(
	"terraria.notify_player_npc_killed.npc_id",
	"NPC ID",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(npc_id)
end

return {
	id = 97,
	build = build,
	fields = {
		npc_id,
	},
}
