local x = ProtoField.float("terraria.play_legacy_sound.x", "X")
local y = ProtoField.float("terraria.play_legacy_sound.y", "Y")
local sound_id = ProtoField.uint16("terraria.play_legacy_sound.sound_id", "Sound ID", base.DEC)
local sound_flags = ProtoField.uint8("terraria.play_legacy_sound.sound_flags", "Sound Flags", base.HEX)

---@param payload PayloadReader
local function build(payload)
	payload:single_le(x)
	payload:single_le(y)
	payload:uint16_le(sound_id)
	payload:uint8(sound_flags)
end

return {
	id = 132,
	build = build,
	fields = {
		x,
		y,
		sound_id,
		sound_flags,
	},
}
