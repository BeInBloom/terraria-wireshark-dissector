local reason = ProtoField.string(
	"terraria.disconnect.reason",
	"Reason"
)

---@param payload PayloadReader
local function build(payload)
	payload:network_text(reason)
end

return {
	id = 2,
	build = build,
	fields = {
		reason,
	},
}
