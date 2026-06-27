local unused = ProtoField.uint8("terraria.set_misc_event_values.unused", "Unused", base.DEC)
local credits_roll_remaining_time = ProtoField.int32(
	"terraria.set_misc_event_values.credits_roll_remaining_time",
	"Credits Roll Remaining Time",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(unused)
	payload:int32_le(credits_roll_remaining_time)
end

return {
	id = 140,
	build = build,
	fields = {
		unused,
		credits_roll_remaining_time,
	},
}
