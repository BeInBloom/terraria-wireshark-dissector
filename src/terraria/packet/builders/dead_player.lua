local player_id = ProtoField.uint8("terraria.dead_player.player_id", "Player ID", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
end

return {
	id = 135,
	build = build,
	fields = {
		player_id,
	},
}
