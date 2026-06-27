local player_id = ProtoField.uint8(
	"terraria.add_player_buff.player_id",
	"Player ID",
	base.DEC
)
local buff = ProtoField.uint16("terraria.add_player_buff.buff", "Buff", base.DEC)
local time = ProtoField.int32("terraria.add_player_buff.time", "Time", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:uint16_le(buff)
	payload:int32_le(time)
end

return {
	id = 55,
	build = build,
	fields = {
		player_id,
		buff,
		time,
	},
}
