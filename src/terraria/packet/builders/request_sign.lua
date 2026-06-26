local x = ProtoField.int16("terraria.request_sign.x", "X", base.DEC)
local y = ProtoField.int16("terraria.request_sign.y", "Y", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(x)
	payload:int16_le(y)
end

return {
	id = 46,
	build = build,
	fields = {
		x,
		y,
	},
}
