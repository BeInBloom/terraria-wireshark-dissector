local player_id = ProtoField.uint8(
	"terraria.player_team.player_id",
	"Player ID",
	base.DEC
)
local team = ProtoField.uint8("terraria.player_team.team", "Team", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:uint8(team)
end

return {
	id = 45,
	build = build,
	fields = {
		player_id,
		team,
	},
}
