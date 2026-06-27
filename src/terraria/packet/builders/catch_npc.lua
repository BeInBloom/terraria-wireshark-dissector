local npc_id = ProtoField.int16("terraria.catch_npc.npc_id", "NPC ID", base.DEC)
local player_id = ProtoField.uint8("terraria.catch_npc.player_id", "Player ID", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(npc_id)
	payload:uint8(player_id)
end

return {
	id = 70,
	build = build,
	fields = {
		npc_id,
		player_id,
	},
}
