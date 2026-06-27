local x = ProtoField.int32("terraria.release_npc.x", "X", base.DEC)
local y = ProtoField.int32("terraria.release_npc.y", "Y", base.DEC)
local npc_type = ProtoField.int16("terraria.release_npc.npc_type", "NPC Type", base.DEC)
local style = ProtoField.uint8("terraria.release_npc.style", "Style", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int32_le(x)
	payload:int32_le(y)
	payload:int16_le(npc_type)
	payload:uint8(style)
end

return {
	id = 71,
	build = build,
	fields = {
		x,
		y,
		npc_type,
		style,
	},
}
