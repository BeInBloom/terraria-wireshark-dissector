local tile_entity_id = ProtoField.int32(
	"terraria.update_tile_entity.tile_entity_id",
	"Tile Entity ID",
	base.DEC
)
local update_tile_flag = ProtoField.bool(
	"terraria.update_tile_entity.update_tile_flag",
	"Update Tile Flag"
)
local tile_entity_type = ProtoField.uint8(
	"terraria.update_tile_entity.tile_entity_type",
	"Tile Entity Type",
	base.DEC
)
local x = ProtoField.int16("terraria.update_tile_entity.x", "X", base.DEC)
local y = ProtoField.int16("terraria.update_tile_entity.y", "Y", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int32_le(tile_entity_id)
	local flag, flag_range = payload.reader:bool()
	payload:add_field(update_tile_flag, flag_range, flag)

	if not flag then
		payload:uint8(tile_entity_type)
		payload:int16_le(x)
		payload:int16_le(y)
	end
end

return {
	id = 86,
	build = build,
	fields = {
		tile_entity_id,
		update_tile_flag,
		tile_entity_type,
		x,
		y,
	},
}
