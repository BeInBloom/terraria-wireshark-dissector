local npc_id = ProtoField.uint16("terraria.tamper_with_npc.npc_id", "NPC ID", base.DEC)
local set_npc_immunity = ProtoField.bool(
	"terraria.tamper_with_npc.set_npc_immunity",
	"Set NPC Immunity"
)
local immunity_time = ProtoField.int32(
	"terraria.tamper_with_npc.immunity_time",
	"Immunity Time",
	base.DEC
)
local immunity_player_id = ProtoField.int16(
	"terraria.tamper_with_npc.immunity_player_id",
	"Immunity Player ID",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint16_le(npc_id)
	local enabled, enabled_range = payload.reader:bool()
	payload:add_field(set_npc_immunity, enabled_range, enabled)

	if enabled then
		payload:int32_le(immunity_time)
	end

	payload:int16_le(immunity_player_id)
end

return {
	id = 131,
	build = build,
	fields = {
		npc_id,
		set_npc_immunity,
		immunity_time,
		immunity_player_id,
	},
}
