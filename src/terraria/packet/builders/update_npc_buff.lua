local npc_id = ProtoField.int16("terraria.update_npc_buff.npc_id", "NPC ID", base.DEC)
local buff_pairs = {}
local fields = { npc_id }

for index = 1, 5 do
	local buff_id = ProtoField.uint16(
		string.format("terraria.update_npc_buff.buff_id_%d", index),
		string.format("Buff ID %d", index),
		base.DEC
	)
	local time = ProtoField.int16(
		string.format("terraria.update_npc_buff.time_%d", index),
		string.format("Time %d", index),
		base.DEC
	)

	buff_pairs[index] = {
		buff_id = buff_id,
		time = time,
	}
	fields[#fields + 1] = buff_id
	fields[#fields + 1] = time
end

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(npc_id)

	for index = 1, #buff_pairs do
		local pair = buff_pairs[index]
		payload:uint16_le(pair.buff_id)
		payload:int16_le(pair.time)
	end
end

return {
	id = 54,
	build = build,
	fields = fields,
}
