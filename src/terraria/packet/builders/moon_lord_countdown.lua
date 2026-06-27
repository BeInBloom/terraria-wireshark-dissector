local moon_lord_countdown = ProtoField.int32(
	"terraria.moon_lord_countdown.value",
	"Moon Lord Countdown",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:int32_le(moon_lord_countdown)
end

return {
	id = 103,
	build = build,
	fields = {
		moon_lord_countdown,
	},
}
