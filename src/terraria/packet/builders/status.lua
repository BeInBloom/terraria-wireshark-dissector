local status_max = ProtoField.int32(
	"terraria.status.max",
	"Status Max",
	base.DEC
)
local message = ProtoField.bytes("terraria.status.message", "Message")
local text = ProtoField.string("terraria.status.text", "Status Text")
local text_flags = ProtoField.uint8(
	"terraria.status.text_flags",
	"Status Text Flags",
	base.HEX
)

---@param payload PayloadReader
local function build_message(payload)
	payload:network_text(text)
	payload:uint8(text_flags)
end

---@param payload PayloadReader
local function build(payload)
	payload:int32_le(status_max)
	payload:group(message, build_message)
end

return {
	id = 9,
	build = build,
	fields = {
		status_max,
		message,
		text,
		text_flags,
	},
}
