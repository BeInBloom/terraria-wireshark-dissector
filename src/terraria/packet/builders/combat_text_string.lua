local x = ProtoField.float("terraria.combat_text_string.x", "X")
local y = ProtoField.float("terraria.combat_text_string.y", "Y")
local color = ProtoField.bytes("terraria.combat_text_string.color", "Color")
local combat_text = ProtoField.string("terraria.combat_text_string.text", "Combat Text")

---@param payload PayloadReader
local function build(payload)
	payload:single_le(x)
	payload:single_le(y)
	payload:color(color)
	payload:network_text(combat_text)
end

return {
	id = 119,
	build = build,
	fields = {
		x,
		y,
		color,
		combat_text,
	},
}
