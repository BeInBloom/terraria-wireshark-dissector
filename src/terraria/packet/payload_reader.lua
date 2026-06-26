local color_reader = require("terraria.packet.readers.color_reader")
local network_text_reader = require("terraria.packet.readers.network_text_reader")
local npc_update_reader = require("terraria.packet.readers.npc_update_reader")
local projectile_update_reader = require("terraria.packet.readers.projectile_update_reader")
local send_tile_square_reader = require("terraria.packet.readers.send_tile_square_reader")
local string_reader = require("terraria.packet.readers.string_reader")
local update_player_reader = require("terraria.packet.readers.update_player_reader")

---@class PayloadReader
---@field reader ByteReader
---@field tree TreeItem
local PayloadReader = {}
PayloadReader.__index = PayloadReader

---@param reader ByteReader
---@param tree TreeItem
---@return PayloadReader
function PayloadReader.new(reader, tree)
	return setmetatable({
		reader = reader,
		tree = tree,
	}, PayloadReader)
end

---@param field ProtoField
---@param range TvbRange?
---@param value any?
function PayloadReader:add_field(field, range, value)
	if not range then
		return
	end

	if value == nil then
		self.tree:add(field, range)
	else
		self.tree:add(field, range, value)
	end
end

---@param field ProtoField
---@param range TvbRange?
---@param value any?
function PayloadReader:add_le_field(field, range, value)
	if not range then
		return
	end

	if value == nil then
		self.tree:add_le(field, range)
	else
		self.tree:add_le(field, range, value)
	end
end

---@param field ProtoField
---@param start integer
---@param err any
function PayloadReader:fail(field, start, err)
	local range = self.reader:range_from(start)
	local item = self.tree:add(field, range)
	local message = string.format(
		"Failed to read payload field at offset %d: %s",
		start,
		tostring(err)
	)

	item:add_expert_info(
		expert.group.MALFORMED,
		expert.severity.ERROR,
		message
	)

	error(err, 0)
end

---@param field ProtoField
function PayloadReader:string(field)
	local start = self.reader:position()
	local strings = string_reader.new(self.reader)
	local ok, value, range = pcall(strings.read, strings)

	if not ok then
		self:fail(field, start, value)
	end

	self:add_field(field, range, value)
end

---@param field ProtoField
function PayloadReader:network_text(field)
	local start = self.reader:position()
	local reader = network_text_reader.new(self.reader)
	local ok, value, range = pcall(reader.read, reader)

	if not ok then
		self:fail(field, start, value)
	end

	self:add_field(field, range, value.text)
end

---@param field ProtoField
function PayloadReader:color(field)
	local reader = color_reader.new(self.reader)
	local _, range = reader:read()
	self:add_field(field, range)
end

---@param field ProtoField
function PayloadReader:bool(field)
	local value, range = self.reader:bool()
	self:add_field(field, range, value)
end

---@param field ProtoField
function PayloadReader:uint8(field)
	local value, range = self.reader:uint8()
	self:add_field(field, range, value)
end

---@param field ProtoField
function PayloadReader:sbyte(field)
	local value, range = self.reader:sbyte()
	self:add_field(field, range, value)
end

---@param field ProtoField
function PayloadReader:uint16_le(field)
	local value, range = self.reader:uint16_le()
	self:add_le_field(field, range, value)
end

---@param field ProtoField
function PayloadReader:int16_le(field)
	local value, range = self.reader:int16_le()
	self:add_le_field(field, range, value)
end

---@param field ProtoField
function PayloadReader:uint32_le(field)
	local value, range = self.reader:uint32_le()
	self:add_le_field(field, range, value)
end

---@param field ProtoField
function PayloadReader:int32_le(field)
	local value, range = self.reader:int32_le()
	self:add_le_field(field, range, value)
end

---@param field ProtoField
function PayloadReader:uint64_le(field)
	local value, range = self.reader:uint64_le()
	self:add_le_field(field, range, value)
end

---@param field ProtoField
function PayloadReader:single_le(field)
	local value, range = self.reader:single_le()
	self:add_le_field(field, range, value)
end

---@param field ProtoField
---@param len integer
function PayloadReader:bytes(field, len)
	local value, range = self.reader:bytes(len)
	self:add_field(field, range, value)
end

---@param field ProtoField
function PayloadReader:remaining_bytes(field)
	self:bytes(field, self.reader:remaining())
end

---@param fields UpdatePlayerFields
function PayloadReader:update_player(fields)
	local value = update_player_reader.new(self.reader):read()

	self:add_update_player_base(fields, value)
	self:add_vector(fields.velocity_x, fields.velocity_y, value.velocity)
	self:add_vector(
		fields.original_position_x,
		fields.original_position_y,
		value.original_position
	)
	self:add_vector(fields.home_position_x, fields.home_position_y, value.home_position)
end

---@param fields UpdatePlayerFields
---@param value TerrariaUpdatePlayer
function PayloadReader:add_update_player_base(fields, value)
	self:add_field(fields.player_id, value.player_id_range, value.player_id)
	self:add_field(fields.control, value.control_range, value.control)
	self:add_field(fields.pulley, value.pulley_range, value.pulley)
	self:add_field(fields.misc, value.misc_range, value.misc)
	self:add_field(fields.sleeping_info, value.sleeping_info_range, value.sleeping_info)
	self:add_field(fields.selected_item, value.selected_item_range, value.selected_item)
	self:add_vector(fields.position_x, fields.position_y, value.position)
end

---@param x_field ProtoField
---@param y_field ProtoField
---@param vector TerrariaRangedVector2?
function PayloadReader:add_vector(x_field, y_field, vector)
	if not vector then
		return
	end

	self:add_le_field(x_field, vector.x_range, vector.x)
	self:add_le_field(y_field, vector.y_range, vector.y)
end

---@param fields SendTileSquareFields
function PayloadReader:send_tile_square(fields)
	local value = send_tile_square_reader.new(self.reader):read()

	self:add_le_field(fields.encoded_size, value.encoded_size_range, value.encoded_size)
	self:add_le_field(fields.size, value.encoded_size_range, value.size)
	self:add_field(fields.tile_change_type, value.tile_change_type_range, value.tile_change_type)
	self:add_le_field(fields.tile_x, value.tile_x_range, value.tile_x)
	self:add_le_field(fields.tile_y, value.tile_y_range, value.tile_y)
	self:add_field(fields.tiles, value.tiles_range)
end

---@param fields NpcUpdateFields
function PayloadReader:npc_update(fields)
	local value = npc_update_reader.new(self.reader):read()

	self:add_npc_update_base(fields, value)
	self:add_npc_update_ai(fields, value)
	self:add_npc_update_optional(fields, value)
end

---@param fields NpcUpdateFields
---@param value TerrariaNpcUpdate
function PayloadReader:add_npc_update_base(fields, value)
	self:add_le_field(fields.npc_id, value.npc_id_range, value.npc_id)
	self:add_vector(fields.position_x, fields.position_y, value.position)
	self:add_vector(fields.velocity_x, fields.velocity_y, value.velocity)
	self:add_le_field(fields.target, value.target_range, value.target)
	self:add_field(fields.flags1, value.flags1_range, value.flags1)
	self:add_field(fields.flags2, value.flags2_range, value.flags2)
end

---@param fields NpcUpdateFields
---@param value TerrariaNpcUpdate
function PayloadReader:add_npc_update_ai(fields, value)
	for index = 1, 4 do
		if value.ai[index] then
			self:add_le_field(fields.ai[index], value.ai_ranges[index], value.ai[index])
		end
	end
end

---@param fields NpcUpdateFields
---@param value TerrariaNpcUpdate
function PayloadReader:add_npc_update_life(fields, value)
	if value.life then
		if value.life_bytes == 1 then
			self:add_field(fields.life, value.life_range, value.life)
		else
			self:add_le_field(fields.life, value.life_range, value.life)
		end
	end

	self:add_field(fields.life_raw, value.life_raw_range)
end

---@param fields NpcUpdateFields
---@param value TerrariaNpcUpdate
function PayloadReader:add_npc_update_optional(fields, value)
	self:add_le_field(fields.npc_net_id, value.npc_net_id_range, value.npc_net_id)
	self:add_field(fields.difficulty_player_count, value.difficulty_player_count_range)
	self:add_le_field(fields.strength_multiplier, value.strength_multiplier_range)
	self:add_field(fields.life_bytes, value.life_bytes_range, value.life_bytes)
	self:add_npc_update_life(fields, value)
	self:add_field(fields.release_owner, value.release_owner_range, value.release_owner)
end

---@param fields ProjectileUpdateFields
function PayloadReader:projectile_update(fields)
	local value = projectile_update_reader.new(self.reader):read()

	self:add_projectile_update_base(fields, value)
	self:add_projectile_update_optional(fields, value)
end

---@param fields ProjectileUpdateFields
---@param value TerrariaProjectileUpdate
function PayloadReader:add_projectile_update_base(fields, value)
	self:add_le_field(fields.projectile_id, value.projectile_id_range, value.projectile_id)
	self:add_vector(fields.position_x, fields.position_y, value.position)
	self:add_vector(fields.velocity_x, fields.velocity_y, value.velocity)
	self:add_field(fields.owner, value.owner_range, value.owner)
	self:add_le_field(fields.projectile_type, value.projectile_type_range, value.projectile_type)
	self:add_field(fields.flags, value.flags_range, value.flags)
end

---@param fields ProjectileUpdateFields
---@param value TerrariaProjectileUpdate
function PayloadReader:add_projectile_update_optional(fields, value)
	self:add_le_field(fields.ai0, value.ai0_range, value.ai0)
	self:add_le_field(fields.ai1, value.ai1_range, value.ai1)
	self:add_le_field(fields.damage, value.damage_range, value.damage)
	self:add_le_field(fields.knockback, value.knockback_range, value.knockback)
	self:add_le_field(fields.original_damage, value.original_damage_range, value.original_damage)
	self:add_le_field(fields.projectile_uuid, value.projectile_uuid_range, value.projectile_uuid)
end

return PayloadReader
