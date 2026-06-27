local player_id = ProtoField.uint8(
	"terraria.update_player_luck_factors.player_id",
	"Player ID",
	base.DEC
)
local ladybug_luck_time_remaining = ProtoField.int32(
	"terraria.update_player_luck_factors.ladybug_luck_time_remaining",
	"Ladybug Luck Time Remaining",
	base.DEC
)
local torch_luck = ProtoField.float("terraria.update_player_luck_factors.torch_luck", "Torch Luck")
local luck_potion = ProtoField.uint8(
	"terraria.update_player_luck_factors.luck_potion",
	"Luck Potion",
	base.DEC
)
local has_garden_gnome_nearby = ProtoField.bool(
	"terraria.update_player_luck_factors.has_garden_gnome_nearby",
	"Has Garden Gnome Nearby"
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:int32_le(ladybug_luck_time_remaining)
	payload:single_le(torch_luck)
	payload:uint8(luck_potion)
	payload:bool(has_garden_gnome_nearby)
end

return {
	id = 134,
	build = build,
	fields = {
		player_id,
		ladybug_luck_time_remaining,
		torch_luck,
		luck_potion,
		has_garden_gnome_nearby,
	},
}
