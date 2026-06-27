local x = ProtoField.int16("terraria.hit_switch.x", "X", base.DEC)
local y = ProtoField.int16("terraria.hit_switch.y", "Y", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(x)
	payload:int16_le(y)
end

return {
	id = 59,
	build = build,
	fields = {
		x,
		y,
	},
}
