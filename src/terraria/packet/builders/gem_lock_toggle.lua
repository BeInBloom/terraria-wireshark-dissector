local x = ProtoField.int16("terraria.gem_lock_toggle.x", "X", base.DEC)
local y = ProtoField.int16("terraria.gem_lock_toggle.y", "Y", base.DEC)
local on = ProtoField.bool("terraria.gem_lock_toggle.on", "On")

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(x)
	payload:int16_le(y)
	payload:bool(on)
end

return {
	id = 105,
	build = build,
	fields = {
		x,
		y,
		on,
	},
}
