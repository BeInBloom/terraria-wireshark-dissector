local progress = ProtoField.int32(
	"terraria.report_invasion_progress.progress",
	"Progress",
	base.DEC
)
local max_progress = ProtoField.int32(
	"terraria.report_invasion_progress.max_progress",
	"Max Progress",
	base.DEC
)
local icon = ProtoField.int8("terraria.report_invasion_progress.icon", "Icon", base.DEC)
local wave = ProtoField.int8("terraria.report_invasion_progress.wave", "Wave", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int32_le(progress)
	payload:int32_le(max_progress)
	payload:sbyte(icon)
	payload:sbyte(wave)
end

return {
	id = 78,
	build = build,
	fields = {
		progress,
		max_progress,
		icon,
		wave,
	},
}
