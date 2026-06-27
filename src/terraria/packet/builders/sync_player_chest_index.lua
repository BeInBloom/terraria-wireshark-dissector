local player = ProtoField.uint8("terraria.sync_player_chest_index.player", "Player", base.DEC)
local chest = ProtoField.int16("terraria.sync_player_chest_index.chest", "Chest", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player)
	payload:int16_le(chest)
end

return {
	id = 80,
	build = build,
	fields = {
		player,
		chest,
	},
}
