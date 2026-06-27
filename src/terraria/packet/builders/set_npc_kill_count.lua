local npc_type = ProtoField.int16(
	"terraria.set_npc_kill_count.npc_type",
	"NPC Type",
	base.DEC
)
local kill_count = ProtoField.int32(
	"terraria.set_npc_kill_count.kill_count",
	"Kill Count",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(npc_type)
	payload:int32_le(kill_count)
end

return {
	id = 83,
	build = build,
	fields = {
		npc_type,
		kill_count,
	},
}
