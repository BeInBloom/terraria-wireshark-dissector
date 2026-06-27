local active_chest = ProtoField.bytes("terraria.sync_active_chest.active_chest", "Active Chest")
local chest_id = ProtoField.int16("terraria.sync_active_chest.chest_id", "Chest ID", base.DEC)
local chest_position = ProtoField.bytes("terraria.sync_active_chest.position", "Chest Position")
local chest_x = ProtoField.int16("terraria.sync_active_chest.chest_x", "Chest X", base.DEC)
local chest_y = ProtoField.int16("terraria.sync_active_chest.chest_y", "Chest Y", base.DEC)
local name_length = ProtoField.uint8("terraria.sync_active_chest.name_length", "Name Length", base.DEC)
local chest_name = ProtoField.string("terraria.sync_active_chest.name", "Chest Name")

---@param payload PayloadReader
local function build_active_chest(payload)
	payload:int16_le(chest_id)
	payload:group(chest_position, function(payload)
		payload:int16_le(chest_x)
		payload:int16_le(chest_y)
	end)
	local len, len_range = payload.reader:uint8()
	payload:add_field(name_length, len_range, len)

	if len > 0 then
		local name, name_range = payload.reader:bytes(len)
		payload:add_field(chest_name, name_range, name)
	end
end

---@param payload PayloadReader
local function build(payload)
	payload:group(active_chest, build_active_chest)
end

return {
	id = 33,
	build = build,
	fields = {
		active_chest,
		chest_id,
		chest_position,
		chest_x,
		chest_y,
		name_length,
		chest_name,
	},
}
