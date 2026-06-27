local event_id = ProtoField.int16(
	"terraria.notify_player_of_event.event_id",
	"Event ID",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(event_id)
end

return {
	id = 98,
	build = build,
	fields = {
		event_id,
	},
}
