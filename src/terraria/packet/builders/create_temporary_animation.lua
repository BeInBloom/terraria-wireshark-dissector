local animation_type = ProtoField.int16(
	"terraria.create_temporary_animation.animation_type",
	"Animation Type",
	base.DEC
)
local tile_type = ProtoField.uint16(
	"terraria.create_temporary_animation.tile_type",
	"Tile Type",
	base.DEC
)
local x = ProtoField.int16("terraria.create_temporary_animation.x", "X", base.DEC)
local y = ProtoField.int16("terraria.create_temporary_animation.y", "Y", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(animation_type)
	payload:uint16_le(tile_type)
	payload:int16_le(x)
	payload:int16_le(y)
end

return {
	id = 77,
	build = build,
	fields = {
		animation_type,
		tile_type,
		x,
		y,
	},
}
