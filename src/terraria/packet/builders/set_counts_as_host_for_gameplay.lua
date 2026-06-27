local player_id = ProtoField.uint8(
	"terraria.set_counts_as_host_for_gameplay.player_id",
	"Player ID",
	base.DEC
)
local counts_as_host = ProtoField.bool(
	"terraria.set_counts_as_host_for_gameplay.counts_as_host",
	"Counts As Host"
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:bool(counts_as_host)
end

return {
	id = 139,
	build = build,
	fields = {
		player_id,
		counts_as_host,
	},
}
