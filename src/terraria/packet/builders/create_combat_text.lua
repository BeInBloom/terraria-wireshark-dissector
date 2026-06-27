local x = ProtoField.float("terraria.create_combat_text.x", "X")
local y = ProtoField.float("terraria.create_combat_text.y", "Y")
local color = ProtoField.bytes("terraria.create_combat_text.color", "Color")
local heal_amount = ProtoField.int32(
	"terraria.create_combat_text.heal_amount",
	"Heal Amount",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:single_le(x)
	payload:single_le(y)
	payload:color(color)
	payload:int32_le(heal_amount)
end

return {
	id = 81,
	build = build,
	fields = {
		x,
		y,
		color,
		heal_amount,
	},
}
