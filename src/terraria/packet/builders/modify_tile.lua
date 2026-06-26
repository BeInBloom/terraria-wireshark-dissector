local action = ProtoField.uint8("terraria.modify_tile.action", "Action", base.DEC)
local tile_x = ProtoField.int16("terraria.modify_tile.tile_x", "Tile X", base.DEC)
local tile_y = ProtoField.int16("terraria.modify_tile.tile_y", "Tile Y", base.DEC)
local flags1 = ProtoField.int16("terraria.modify_tile.flags1", "Flags 1", base.DEC)
local flags2 = ProtoField.uint8("terraria.modify_tile.flags2", "Flags 2", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(action)
	payload:int16_le(tile_x)
	payload:int16_le(tile_y)
	payload:int16_le(flags1)
	payload:uint8(flags2)
end

return {
	id = 17,
	build = build,
	fields = {
		action,
		tile_x,
		tile_y,
		flags1,
		flags2,
	},
}
