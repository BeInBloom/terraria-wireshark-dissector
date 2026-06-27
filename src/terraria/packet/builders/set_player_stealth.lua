local player = ProtoField.uint8("terraria.set_player_stealth.player", "Player", base.DEC)
local stealth = ProtoField.float("terraria.set_player_stealth.stealth", "Stealth")

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player)
	payload:single_le(stealth)
end

return {
	id = 84,
	build = build,
	fields = {
		player,
		stealth,
	},
}
