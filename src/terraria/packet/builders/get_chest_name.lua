local chest_id = ProtoField.int16("terraria.get_chest_name.chest_id", "Chest ID", base.DEC)
local chest_x = ProtoField.int16("terraria.get_chest_name.chest_x", "Chest X", base.DEC)
local chest_y = ProtoField.int16("terraria.get_chest_name.chest_y", "Chest Y", base.DEC)
local name = ProtoField.string("terraria.get_chest_name.name", "Name")

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(chest_id)
	payload:int16_le(chest_x)
	payload:int16_le(chest_y)
	payload:string(name)
end

return {
	id = 69,
	build = build,
	fields = {
		chest_id,
		chest_x,
		chest_y,
		name,
	},
}
