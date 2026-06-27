local player_id = ProtoField.uint8("terraria.sync_tile_picking.player_id", "Player ID", base.DEC)
local x = ProtoField.int16("terraria.sync_tile_picking.x", "X", base.DEC)
local y = ProtoField.int16("terraria.sync_tile_picking.y", "Y", base.DEC)
local pick_damage = ProtoField.uint8("terraria.sync_tile_picking.pick_damage", "Pick Damage", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:int16_le(x)
	payload:int16_le(y)
	payload:uint8(pick_damage)
end

return {
	id = 125,
	build = build,
	fields = {
		player_id,
		x,
		y,
		pick_damage,
	},
}
