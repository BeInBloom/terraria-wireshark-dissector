local x = ProtoField.int16("terraria.crystal_invasion_start.x", "X", base.DEC)
local y = ProtoField.int16("terraria.crystal_invasion_start.y", "Y", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(x)
	payload:int16_le(y)
end

return {
	id = 113,
	build = build,
	fields = {
		x,
		y,
	},
}
