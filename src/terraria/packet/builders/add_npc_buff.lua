local npc_id = ProtoField.int16("terraria.add_npc_buff.npc_id", "NPC ID", base.DEC)
local buff = ProtoField.uint16("terraria.add_npc_buff.buff", "Buff", base.DEC)
local time = ProtoField.int16("terraria.add_npc_buff.time", "Time", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(npc_id)
	payload:uint16_le(buff)
	payload:int16_le(time)
end

return {
	id = 53,
	build = build,
	fields = {
		npc_id,
		buff,
		time,
	},
}
