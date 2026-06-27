local action = ProtoField.uint8("terraria.door_toggle.action", "Action", base.DEC)
local tile_position = ProtoField.bytes("terraria.door_toggle.position", "Tile Position")
local tile_x = ProtoField.int16("terraria.door_toggle.tile_x", "Tile X", base.DEC)
local tile_y = ProtoField.int16("terraria.door_toggle.tile_y", "Tile Y", base.DEC)
local direction = ProtoField.uint8("terraria.door_toggle.direction", "Direction", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(action)
	payload:group(tile_position, function(payload)
		payload:int16_le(tile_x)
		payload:int16_le(tile_y)
	end)
	payload:uint8(direction)
end

return {
	id = 19,
	build = build,
	fields = {
		action,
		tile_position,
		tile_x,
		tile_y,
		direction,
	},
}
