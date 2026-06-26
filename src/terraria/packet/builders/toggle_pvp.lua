local player_id = ProtoField.uint8("terraria.toggle_pvp.player_id", "Player ID", base.DEC)
local enabled = ProtoField.bool("terraria.toggle_pvp.enabled", "PVP Enabled")

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:bool(enabled)
end

return {
	id = 30,
	build = build,
	fields = {
		player_id,
		enabled,
	},
}
