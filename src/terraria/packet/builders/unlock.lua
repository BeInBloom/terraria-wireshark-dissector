local unlock_type = ProtoField.uint8(
	"terraria.unlock.unlock_type",
	"Unlock Type",
	base.DEC
)
local x = ProtoField.int16("terraria.unlock.x", "X", base.DEC)
local y = ProtoField.int16("terraria.unlock.y", "Y", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(unlock_type)
	payload:int16_le(x)
	payload:int16_le(y)
end

return {
	id = 52,
	build = build,
	fields = {
		unlock_type,
		x,
		y,
	},
}
