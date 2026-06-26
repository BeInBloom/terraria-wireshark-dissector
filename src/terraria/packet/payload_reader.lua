local color_reader = require("terraria.packet.readers.color_reader")
local network_text_reader = require("terraria.packet.readers.network_text_reader")
local npc_update_reader = require("terraria.packet.readers.npc_update_reader")
local projectile_update_reader = require("terraria.packet.readers.projectile_update_reader")
local send_tile_square_reader = require("terraria.packet.readers.send_tile_square_reader")
local string_reader = require("terraria.packet.readers.string_reader")
local update_item_drop_reader = require("terraria.packet.readers.update_item_drop_reader")
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

---@param tree TreeItem?
---@param field ProtoField
---@param range TvbRange?
---@param value any?
function PayloadReader:add_tree_field(tree, field, range, value)
	if not tree or not range then
		return
	end

	if value == nil then
		tree:add(field, range)
	else
		tree:add(field, range, value)
	end
end

---@param tree TreeItem?
---@param field ProtoField
---@param range TvbRange?
---@param value any?
function PayloadReader:add_tree_le_field(tree, field, range, value)
	if not tree or not range then
		return
	end

	if value == nil then
		tree:add_le(field, range)
	else
		tree:add_le(field, range, value)
	end
end

---@param field ProtoField
---@param range TvbRange?
---@param value any?
function PayloadReader:add_field(field, range, value)
	self:add_tree_field(self.tree, field, range, value)
end

---@param field ProtoField
---@param range TvbRange?
---@param value any?
function PayloadReader:add_le_field(field, range, value)
	self:add_tree_le_field(self.tree, field, range, value)
end

---@param parent TreeItem
---@param field ProtoField
---@param range TvbRange
---@return TreeItem
function PayloadReader:add_group(parent, field, range)
	return parent:add(field, range)
end

---@param parent TreeItem
---@param field ProtoField
---@param range TvbRange?
---@return TreeItem?
function PayloadReader:add_optional_group(parent, field, range)
	if not range then
		return nil
	end

	return self:add_group(parent, field, range)
end

---@overload fun(self: PayloadReader, field: ProtoField, read: fun(payload: PayloadReader))
---@overload fun(self: PayloadReader, field: ProtoField, label: string, read: fun(payload: PayloadReader))
---@param field ProtoField
---@param label_or_read any
---@param maybe_read? any
function PayloadReader:group(field, label_or_read, maybe_read)
	local start = self.reader:position()
	local item = self.tree:add(field, self.reader.source:range(start, self.reader:remaining()))
	local payload = PayloadReader.new(self.reader, item)
	local label = nil
	local read = label_or_read

	if maybe_read then
		label = label_or_read
		read = maybe_read
	end

	local ok, err = pcall(read, payload)

	item:set_len(self.reader:position() - start)

	if label then
		item:set_text(label)
	end

	if not ok then
		error(err, 0)
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

---@param group_field ProtoField
---@param x_field ProtoField
---@param y_field ProtoField
function PayloadReader:int16_pair(group_field, x_field, y_field)
	local start = self.reader:position()
	local x, x_range = self.reader:int16_le()
	local y, y_range = self.reader:int16_le()
	local tree = self:add_group(self.tree, group_field, self.reader:range_from(start))

	self:add_tree_le_field(tree, x_field, x_range, x)
	self:add_tree_le_field(tree, y_field, y_range, y)
end

---@param group_field ProtoField
---@param x_field ProtoField
---@param y_field ProtoField
function PayloadReader:int32_pair(group_field, x_field, y_field)
	local start = self.reader:position()
	local x, x_range = self.reader:int32_le()
	local y, y_range = self.reader:int32_le()
	local tree = self:add_group(self.tree, group_field, self.reader:range_from(start))

	self:add_tree_le_field(tree, x_field, x_range, x)
	self:add_tree_le_field(tree, y_field, y_range, y)
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
	local value, range = update_player_reader.new(self.reader):read()
	local tree = self:add_group(self.tree, fields.root, range)

	self:add_update_player_base(tree, fields, value)
	self:add_vector_group(tree, fields.position, fields.position_x, fields.position_y, value.position)
	self:add_vector_group(tree, fields.velocity, fields.velocity_x, fields.velocity_y, value.velocity)
	self:add_vector_group(
		tree,
		fields.original_position,
		fields.original_position_x,
		fields.original_position_y,
		value.original_position
	)
	self:add_vector_group(
		tree,
		fields.home_position,
		fields.home_position_x,
		fields.home_position_y,
		value.home_position
	)
end

---@param tree TreeItem
---@param fields UpdatePlayerFields
---@param value TerrariaUpdatePlayer
function PayloadReader:add_update_player_base(tree, fields, value)
	self:add_tree_field(tree, fields.player_id, value.player_id_range, value.player_id)
	self:add_tree_field(tree, fields.control, value.control_range, value.control)
	self:add_tree_field(tree, fields.pulley, value.pulley_range, value.pulley)
	self:add_tree_field(tree, fields.misc, value.misc_range, value.misc)
	self:add_tree_field(tree, fields.sleeping_info, value.sleeping_info_range, value.sleeping_info)
	self:add_tree_field(tree, fields.selected_item, value.selected_item_range, value.selected_item)
end

---@param parent TreeItem
---@param group_field ProtoField
---@param x_field ProtoField
---@param y_field ProtoField
---@param vector TerrariaRangedVector2?
function PayloadReader:add_vector_group(parent, group_field, x_field, y_field, vector)
	if not vector then
		return
	end

	local tree = self:add_group(parent, group_field, vector.range)

	self:add_tree_le_field(tree, x_field, vector.x_range, vector.x)
	self:add_tree_le_field(tree, y_field, vector.y_range, vector.y)
end

---@param fields SendTileSquareFields
function PayloadReader:send_tile_square(fields)
	local value, range = send_tile_square_reader.new(self.reader):read()
	local tree = self:add_group(self.tree, fields.root, range)
	local header = self:add_group(tree, fields.header, value.header_range)

	self:add_tree_le_field(header, fields.encoded_size, value.encoded_size_range, value.encoded_size)
	self:add_tree_le_field(header, fields.size, value.encoded_size_range, value.size)
	self:add_tree_field(header, fields.tile_change_type, value.tile_change_type_range, value.tile_change_type)
	self:add_tree_le_field(header, fields.tile_x, value.tile_x_range, value.tile_x)
	self:add_tree_le_field(header, fields.tile_y, value.tile_y_range, value.tile_y)
	self:add_tree_field(tree, fields.tiles, value.tiles_range)
end

---@param fields UpdateItemDropFields
function PayloadReader:update_item_drop(fields)
	local value, range = update_item_drop_reader.new(self.reader):read()
	local tree = self:add_group(self.tree, fields.root, range)

	self:add_tree_le_field(tree, fields.item_id, value.item_id_range, value.item_id)
	self:add_vector_group(tree, fields.position, fields.position_x, fields.position_y, value.position)
	self:add_vector_group(tree, fields.velocity, fields.velocity_x, fields.velocity_y, value.velocity)
	self:add_update_item_drop_item(tree, fields, value)
end

---@param tree TreeItem
---@param fields UpdateItemDropFields
---@param value TerrariaUpdateItemDrop
function PayloadReader:add_update_item_drop_item(tree, fields, value)
	local item = self:add_group(tree, fields.item, value.item_range)

	self:add_tree_le_field(item, fields.stack_size, value.stack_size_range, value.stack_size)
	self:add_tree_field(item, fields.prefix, value.prefix_range, value.prefix)
	self:add_tree_field(item, fields.no_delay, value.no_delay_range, value.no_delay)
	self:add_tree_le_field(item, fields.item_net_id, value.item_net_id_range, value.item_net_id)
end

---@param fields NpcUpdateFields
function PayloadReader:npc_update(fields)
	local value, range = npc_update_reader.new(self.reader):read()
	local tree = self:add_group(self.tree, fields.root, range)

	self:add_npc_update_base(tree, fields, value)
	self:add_npc_update_ai(tree, fields, value)
	self:add_npc_update_optional(tree, fields, value)
end

---@param tree TreeItem
---@param fields NpcUpdateFields
---@param value TerrariaNpcUpdate
function PayloadReader:add_npc_update_base(tree, fields, value)
	self:add_tree_le_field(tree, fields.npc_id, value.npc_id_range, value.npc_id)
	self:add_vector_group(tree, fields.position, fields.position_x, fields.position_y, value.position)
	self:add_vector_group(tree, fields.velocity, fields.velocity_x, fields.velocity_y, value.velocity)
	self:add_tree_le_field(tree, fields.target, value.target_range, value.target)
	self:add_tree_field(tree, fields.flags1, value.flags1_range, value.flags1)
	self:add_tree_field(tree, fields.flags2, value.flags2_range, value.flags2)
end

---@param tree TreeItem
---@param fields NpcUpdateFields
---@param value TerrariaNpcUpdate
function PayloadReader:add_npc_update_ai(tree, fields, value)
	local ai = self:add_optional_group(tree, fields.ai_group, value.ai_range)

	for index = 1, 4 do
		if value.ai[index] then
			self:add_tree_le_field(ai, fields.ai[index], value.ai_ranges[index], value.ai[index])
		end
	end
end

---@param tree TreeItem
---@param fields NpcUpdateFields
---@param value TerrariaNpcUpdate
function PayloadReader:add_npc_update_life(tree, fields, value)
	local life = self:add_optional_group(tree, fields.life_group, value.life_group_range)

	self:add_tree_field(life, fields.life_bytes, value.life_bytes_range, value.life_bytes)

	if value.life then
		if value.life_bytes == 1 then
			self:add_tree_field(life, fields.life, value.life_range, value.life)
		else
			self:add_tree_le_field(life, fields.life, value.life_range, value.life)
		end
	end

	self:add_tree_field(life, fields.life_raw, value.life_raw_range)
end

---@param tree TreeItem
---@param fields NpcUpdateFields
---@param value TerrariaNpcUpdate
function PayloadReader:add_npc_update_optional(tree, fields, value)
	self:add_tree_le_field(tree, fields.npc_net_id, value.npc_net_id_range, value.npc_net_id)
	self:add_tree_field(tree, fields.difficulty_player_count, value.difficulty_player_count_range)
	self:add_tree_le_field(tree, fields.strength_multiplier, value.strength_multiplier_range)
	self:add_npc_update_life(tree, fields, value)
	self:add_tree_field(tree, fields.release_owner, value.release_owner_range, value.release_owner)
end

---@param fields ProjectileUpdateFields
function PayloadReader:projectile_update(fields)
	local value, range = projectile_update_reader.new(self.reader):read()
	local tree = self:add_group(self.tree, fields.root, range)

	self:add_projectile_update_base(tree, fields, value)
	self:add_projectile_update_ai(tree, fields, value)
	self:add_projectile_update_stats(tree, fields, value)
end

---@param tree TreeItem
---@param fields ProjectileUpdateFields
---@param value TerrariaProjectileUpdate
function PayloadReader:add_projectile_update_base(tree, fields, value)
	self:add_tree_le_field(tree, fields.projectile_id, value.projectile_id_range, value.projectile_id)
	self:add_vector_group(tree, fields.position, fields.position_x, fields.position_y, value.position)
	self:add_vector_group(tree, fields.velocity, fields.velocity_x, fields.velocity_y, value.velocity)
	self:add_tree_field(tree, fields.owner, value.owner_range, value.owner)
	self:add_tree_le_field(tree, fields.projectile_type, value.projectile_type_range, value.projectile_type)
	self:add_tree_field(tree, fields.flags, value.flags_range, value.flags)
end

---@param tree TreeItem
---@param fields ProjectileUpdateFields
---@param value TerrariaProjectileUpdate
function PayloadReader:add_projectile_update_ai(tree, fields, value)
	local ai = self:add_optional_group(tree, fields.ai_group, value.ai_range)

	self:add_tree_le_field(ai, fields.ai0, value.ai0_range, value.ai0)
	self:add_tree_le_field(ai, fields.ai1, value.ai1_range, value.ai1)
end

---@param tree TreeItem
---@param fields ProjectileUpdateFields
---@param value TerrariaProjectileUpdate
function PayloadReader:add_projectile_update_stats(tree, fields, value)
	local stats = self:add_optional_group(tree, fields.stats_group, value.stats_range)

	self:add_tree_le_field(stats, fields.damage, value.damage_range, value.damage)
	self:add_tree_le_field(stats, fields.knockback, value.knockback_range, value.knockback)
	self:add_tree_le_field(stats, fields.original_damage, value.original_damage_range, value.original_damage)
	self:add_tree_le_field(stats, fields.projectile_uuid, value.projectile_uuid_range, value.projectile_uuid)
end

return PayloadReader
