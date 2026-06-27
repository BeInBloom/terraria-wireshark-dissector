local x = ProtoField.uint16("terraria.fish_out_npc.x", "X", base.DEC)
local y = ProtoField.uint16("terraria.fish_out_npc.y", "Y", base.DEC)
local npc_id = ProtoField.int16("terraria.fish_out_npc.npc_id", "NPC ID", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint16_le(x)
	payload:uint16_le(y)
	payload:int16_le(npc_id)
end

return {
	id = 130,
	build = build,
	fields = {
		x,
		y,
		npc_id,
	},
}
