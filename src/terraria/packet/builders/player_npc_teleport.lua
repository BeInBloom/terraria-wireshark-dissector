local flags = ProtoField.uint8("terraria.player_npc_teleport.flags", "Flags", base.HEX)
local target_id = ProtoField.int16(
	"terraria.player_npc_teleport.target_id",
	"Target ID",
	base.DEC
)
local x = ProtoField.float("terraria.player_npc_teleport.x", "X")
local y = ProtoField.float("terraria.player_npc_teleport.y", "Y")
local style = ProtoField.uint8("terraria.player_npc_teleport.style", "Style", base.DEC)
local extra_info = ProtoField.int32(
	"terraria.player_npc_teleport.extra_info",
	"Extra Info",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	local flags_value, flags_range = payload.reader:uint8()
	payload:add_field(flags, flags_range, flags_value)
	payload:int16_le(target_id)
	payload:single_le(x)
	payload:single_le(y)
	payload:uint8(style)

	if (flags_value & 0x08) ~= 0 then
		payload:int32_le(extra_info)
	end
end

return {
	id = 65,
	build = build,
	fields = {
		flags,
		target_id,
		x,
		y,
		style,
		extra_info,
	},
}
