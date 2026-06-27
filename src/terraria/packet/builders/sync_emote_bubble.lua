local emote_id = ProtoField.int32("terraria.sync_emote_bubble.emote_id", "Emote ID", base.DEC)
local anchor_type = ProtoField.uint8(
	"terraria.sync_emote_bubble.anchor_type",
	"Anchor Type",
	base.DEC
)
local player_id = ProtoField.uint16(
	"terraria.sync_emote_bubble.player_id",
	"Player ID",
	base.DEC
)
local emote_lifetime = ProtoField.uint16(
	"terraria.sync_emote_bubble.emote_lifetime",
	"Emote Lifetime",
	base.DEC
)
local emote = ProtoField.int8("terraria.sync_emote_bubble.emote", "Emote", base.DEC)
local emote_metadata = ProtoField.int16(
	"terraria.sync_emote_bubble.emote_metadata",
	"Emote Metadata",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:int32_le(emote_id)
	local anchor_type_value, anchor_type_range = payload.reader:uint8()
	payload:add_field(anchor_type, anchor_type_range, anchor_type_value)

	if anchor_type_value ~= 255 then
		payload:uint16_le(player_id)
		payload:uint16_le(emote_lifetime)
		local emote_value, emote_range = payload.reader:sbyte()
		payload:add_field(emote, emote_range, emote_value)

		if emote_value < 0 then
			payload:int16_le(emote_metadata)
		end
	end
end

return {
	id = 91,
	build = build,
	fields = {
		emote_id,
		anchor_type,
		player_id,
		emote_lifetime,
		emote,
		emote_metadata,
	},
}
