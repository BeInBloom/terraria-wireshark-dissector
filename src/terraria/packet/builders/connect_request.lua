local version = ProtoField.string(
	"terraria.connect_request.version",
	"Client Version"
)

---@param payload PayloadReader
local function build(payload)
	payload:string(version)
end

return {
	id = 1,
	build = build,
	fields = {
		version,
	},
}
