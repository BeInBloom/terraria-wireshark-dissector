local sign_id = ProtoField.int16(
	"terraria.update_sign.sign_id",
	"Sign ID",
	base.DEC
)
local x = ProtoField.int16("terraria.update_sign.x", "X", base.DEC)
local y = ProtoField.int16("terraria.update_sign.y", "Y", base.DEC)
local text = ProtoField.string("terraria.update_sign.text", "Text")
local player_id = ProtoField.uint8(
	"terraria.update_sign.player_id",
	"Player ID",
	base.DEC
)
local sign_flags = ProtoField.uint8(
	"terraria.update_sign.sign_flags",
	"Sign Flags",
	base.HEX
)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(sign_id)
	payload:int16_le(x)
	payload:int16_le(y)
	payload:string(text)
	payload:uint8(player_id)
	payload:uint8(sign_flags)
end

return {
	id = 47,
	build = build,
	fields = {
		sign_id,
		x,
		y,
		text,
		player_id,
		sign_flags,
	},
}
