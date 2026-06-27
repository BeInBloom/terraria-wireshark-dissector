local message_color = ProtoField.bytes(
	"terraria.smart_text_message.message_color",
	"Message Color"
)
local text = ProtoField.string("terraria.smart_text_message.text", "Message")
local message_length = ProtoField.int16(
	"terraria.smart_text_message.message_length",
	"Message Length",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:color(message_color)
	payload:network_text(text)
	payload:int16_le(message_length)
end

return {
	id = 107,
	build = build,
	fields = {
		message_color,
		text,
		message_length,
	},
}
