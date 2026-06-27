local time_until_next_wave = ProtoField.int32(
	"terraria.crystal_invasion_send_wait_time.time_until_next_wave",
	"Time Until Next Wave",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:int32_le(time_until_next_wave)
end

return {
	id = 116,
	build = build,
	fields = {
		time_until_next_wave,
	},
}
