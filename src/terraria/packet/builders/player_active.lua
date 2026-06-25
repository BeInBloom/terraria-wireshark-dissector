local player_id = ProtoField.uint8(
	"terraria.player_active.player_id",
	"Player ID",
	base.DEC
)
local active = ProtoField.uint8(
	"terraria.player_active.active",
	"Active",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:uint8(active)
end

return {
	id = 14,
	build = build,
	fields = {
		player_id,
		active,
	},
}
