local good = ProtoField.uint8("terraria.update_good_evil.good", "Good", base.DEC)
local evil = ProtoField.uint8("terraria.update_good_evil.evil", "Evil", base.DEC)
local crimson = ProtoField.uint8("terraria.update_good_evil.crimson", "Crimson", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(good)
	payload:uint8(evil)
	payload:uint8(crimson)
end

return {
	id = 57,
	build = build,
	fields = {
		good,
		evil,
		crimson,
	},
}
