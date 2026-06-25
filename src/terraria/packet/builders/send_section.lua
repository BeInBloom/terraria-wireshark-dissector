local compressed = ProtoField.bool(
	"terraria.send_section.compressed",
	"Compressed"
)
local section_data = ProtoField.bytes(
	"terraria.send_section.data",
	"Section Data"
)

---@param payload PayloadReader
local function build(payload)
	payload:bool(compressed)
	payload:remaining_bytes(section_data)
end

return {
	id = 10,
	build = build,
	fields = {
		compressed,
		section_data,
	},
}
