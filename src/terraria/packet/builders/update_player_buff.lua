local player_id = ProtoField.uint8(
	"terraria.update_player_buff.player_id",
	"Player ID",
	base.DEC
)
local buffs = ProtoField.bytes("terraria.update_player_buff.buffs", "Buffs")
local buff_types = {}

for index = 1, 22 do
	buff_types[index] = ProtoField.uint16(
		string.format("terraria.update_player_buff.buff_type_%02d", index),
		string.format("Buff Type %02d", index),
		base.DEC
	)
end

---@param payload PayloadReader
local function build_buffs(payload)
	for index = 1, 22 do
		if payload.reader:remaining() < 2 then
			return
		end

		payload:uint16_le(buff_types[index])
	end
end

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:group(buffs, build_buffs)
end

local fields = {
	player_id,
	buffs,
}

for index = 1, 22 do
	fields[#fields + 1] = buff_types[index]
end

return {
	id = 50,
	build = build,
	fields = fields,
}
