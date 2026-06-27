local effect_flags = ProtoField.uint8("terraria.growfx.effect_flags", "Effect Flags", base.HEX)
local x = ProtoField.int32("terraria.growfx.x", "X", base.DEC)
local y = ProtoField.int32("terraria.growfx.y", "Y", base.DEC)
local data = ProtoField.uint8("terraria.growfx.data", "Data", base.DEC)
local tree_gore = ProtoField.int16("terraria.growfx.tree_gore", "Tree Gore", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(effect_flags)
	payload:int32_le(x)
	payload:int32_le(y)
	payload:uint8(data)
	payload:int16_le(tree_gore)
end

return {
	id = 112,
	build = build,
	fields = {
		effect_flags,
		x,
		y,
		data,
		tree_gore,
	},
}
