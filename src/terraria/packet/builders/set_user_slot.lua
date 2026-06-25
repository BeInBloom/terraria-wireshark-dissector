local player_id = ProtoField.uint8(
	"terraria.set_user_slot.player_id",
	"Player ID",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
end

return {
	id = 3,
	build = build,
	fields = {
		player_id,
	},
}
