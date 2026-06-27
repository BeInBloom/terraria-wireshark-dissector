local projectile_update_reader = require("terraria.packet.readers.projectile_update_reader")

local fields = {}

---@param factory fun(name: string, label: string, display: any): ProtoField
---@param name string
---@param label string
---@param display any
---@return ProtoField
local function define(factory, name, label, display)
	local field = factory("terraria.projectile_update." .. name, label, display)
	fields[#fields + 1] = field
	return field
end

local field_map = {
	root = define(ProtoField.bytes, "root", "Projectile Update"),
	projectile_id = define(ProtoField.int16, "projectile_id", "Projectile ID", base.DEC),
	position = define(ProtoField.bytes, "position", "Position"),
	position_x = define(ProtoField.float, "position_x", "Position X"),
	position_y = define(ProtoField.float, "position_y", "Position Y"),
	velocity = define(ProtoField.bytes, "velocity", "Velocity"),
	velocity_x = define(ProtoField.float, "velocity_x", "Velocity X"),
	velocity_y = define(ProtoField.float, "velocity_y", "Velocity Y"),
	owner = define(ProtoField.uint8, "owner", "Owner", base.DEC),
	projectile_type = define(ProtoField.int16, "projectile_type", "Type", base.DEC),
	flags = define(ProtoField.uint8, "flags", "Projectile Flags", base.HEX),
	ai_group = define(ProtoField.bytes, "ai", "AI"),
	ai0 = define(ProtoField.float, "ai0", "AI 0"),
	ai1 = define(ProtoField.float, "ai1", "AI 1"),
	stats_group = define(ProtoField.bytes, "stats", "Stats"),
	damage = define(ProtoField.int16, "damage", "Damage", base.DEC),
	knockback = define(ProtoField.float, "knockback", "Knockback"),
	original_damage = define(ProtoField.int16, "original_damage", "Original Damage", base.DEC),
	projectile_uuid = define(ProtoField.int16, "projectile_uuid", "Projectile UUID", base.DEC),
}

local vectors = {
	position = {
		group_field = field_map.position,
		x_field = field_map.position_x,
		y_field = field_map.position_y,
	},
	velocity = {
		group_field = field_map.velocity,
		x_field = field_map.velocity_x,
		y_field = field_map.velocity_y,
	},
}

---@param parent TreeItem
---@param spec { group_field: ProtoField, x_field: ProtoField, y_field: ProtoField }
---@param vector TerrariaRangedVector2?
local function add_vector_group(parent, spec, vector)
	if not vector then
		return
	end

	local tree = parent:add(spec.group_field, vector.range)
	tree:add_le(spec.x_field, vector.x_range, vector.x)
	tree:add_le(spec.y_field, vector.y_range, vector.y)
end

---@param tree TreeItem
---@param field_map table
---@param value TerrariaProjectileUpdate
---@return nil
local function add_projectile_update_base(tree, field_map, value)
	tree:add_le(field_map.projectile_id, value.projectile_id_range, value.projectile_id)
	add_vector_group(tree, vectors.position, value.position)
	add_vector_group(tree, vectors.velocity, value.velocity)
	tree:add(field_map.owner, value.owner_range, value.owner)
	tree:add_le(field_map.projectile_type, value.projectile_type_range, value.projectile_type)
	tree:add(field_map.flags, value.flags_range, value.flags)
end

---@param tree TreeItem
---@param field_map table
---@param value TerrariaProjectileUpdate
---@return nil
local function add_projectile_update_ai(tree, field_map, value)
	local ai = value.ai_range and tree:add(field_map.ai_group, value.ai_range) or nil

	if ai then
		if value.ai0_range then
			ai:add_le(field_map.ai0, value.ai0_range, value.ai0)
		end

		if value.ai1_range then
			ai:add_le(field_map.ai1, value.ai1_range, value.ai1)
		end
	end
end

---@param tree TreeItem
---@param field_map table
---@param value TerrariaProjectileUpdate
---@return nil
local function add_projectile_update_stats(tree, field_map, value)
	local stats = value.stats_range and tree:add(field_map.stats_group, value.stats_range) or nil

	if stats then
		if value.damage_range then
			stats:add_le(field_map.damage, value.damage_range, value.damage)
		end

		if value.knockback_range then
			stats:add_le(field_map.knockback, value.knockback_range, value.knockback)
		end

		if value.original_damage_range then
			stats:add_le(field_map.original_damage, value.original_damage_range, value.original_damage)
		end

		if value.projectile_uuid_range then
			stats:add_le(field_map.projectile_uuid, value.projectile_uuid_range, value.projectile_uuid)
		end
	end
end

---@param payload PayloadReader
---@return nil
local function build(payload)
	local value, range = projectile_update_reader.new(payload.reader):read()
	local tree = payload.tree:add(field_map.root, range)

	add_projectile_update_base(tree, field_map, value)
	add_projectile_update_ai(tree, field_map, value)
	add_projectile_update_stats(tree, field_map, value)
end

return {
	id = 27,
	build = build,
	fields = fields,
}
