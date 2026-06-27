local npc_id = ProtoField.int16("terraria.request_npc_buff_removal.npc_id", "NPC ID", base.DEC)
local buff_id = ProtoField.uint16("terraria.request_npc_buff_removal.buff_id", "Buff ID", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(npc_id)
	payload:uint16_le(buff_id)
end

return {
	id = 137,
	build = build,
	fields = {
		npc_id,
		buff_id,
	},
}
