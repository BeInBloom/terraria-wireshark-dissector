local player_id = ProtoField.uint8(
	"terraria.player_item_animation.player_id",
	"Player ID",
	base.DEC
)
local item_rotation = ProtoField.float(
	"terraria.player_item_animation.item_rotation",
	"Item Rotation"
)
local item_animation = ProtoField.int16(
	"terraria.player_item_animation.item_animation",
	"Item Animation",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:single_le(item_rotation)
	payload:int16_le(item_animation)
end

return {
	id = 41,
	build = build,
	fields = {
		player_id,
		item_rotation,
		item_animation,
	},
}
