local player_id = ProtoField.uint8(
	"terraria.player_dodge.player_id",
	"Player ID",
	base.DEC
)
local flag = ProtoField.uint8("terraria.player_dodge.flag", "Flag", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:uint8(flag)
end

return {
	id = 62,
	build = build,
	fields = {
		player_id,
		flag,
	},
}
