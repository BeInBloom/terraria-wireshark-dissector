local npc_update_reader = require("terraria.packet.readers.npc_update_reader")

local fields = {}

---@param factory fun(name: string, label: string, display: any): ProtoField
---@param name string
---@param label string
---@param display any
---@return ProtoField
local function define(factory, name, label, display)
	local field = factory("terraria.npc_update." .. name, label, display)
	fields[#fields + 1] = field
	return field
end

local field_map = {
	root = define(ProtoField.bytes, "root", "NPC Update"),
	npc_id = define(ProtoField.int16, "npc_id", "NPC ID", base.DEC),
	position = define(ProtoField.bytes, "position", "Position"),
	position_x = define(ProtoField.float, "position_x", "Position X"),
	position_y = define(ProtoField.float, "position_y", "Position Y"),
	velocity = define(ProtoField.bytes, "velocity", "Velocity"),
	velocity_x = define(ProtoField.float, "velocity_x", "Velocity X"),
	velocity_y = define(ProtoField.float, "velocity_y", "Velocity Y"),
	target = define(ProtoField.uint16, "target", "Target", base.DEC),
	flags1 = define(ProtoField.uint8, "flags1", "NPC Flags 1", base.HEX),
	flags2 = define(ProtoField.uint8, "flags2", "NPC Flags 2", base.HEX),
	ai_group = define(ProtoField.bytes, "ai", "AI"),
	ai = {
		define(ProtoField.float, "ai0", "AI 0"),
		define(ProtoField.float, "ai1", "AI 1"),
		define(ProtoField.float, "ai2", "AI 2"),
		define(ProtoField.float, "ai3", "AI 3"),
	},
	npc_net_id = define(ProtoField.int16, "npc_net_id", "NPC Net ID", base.DEC),
	difficulty_player_count = define(
		ProtoField.uint8,
		"difficulty_player_count",
		"Difficulty Player Count",
		base.DEC
	),
	strength_multiplier = define(ProtoField.float, "strength_multiplier", "Strength Multiplier"),
	life_group = define(ProtoField.bytes, "life_group", "Life"),
	life_bytes = define(ProtoField.uint8, "life_bytes", "Life Bytes", base.DEC),
	life = define(ProtoField.int32, "life", "Life", base.DEC),
	life_raw = define(ProtoField.bytes, "life_raw", "Raw Life"),
	release_owner = define(ProtoField.uint8, "release_owner", "Release Owner", base.DEC),
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
---@param value TerrariaNpcUpdate
---@return nil
local function add_npc_update_base(tree, field_map, value)
	tree:add_le(field_map.npc_id, value.npc_id_range, value.npc_id)
	add_vector_group(tree, vectors.position, value.position)
	add_vector_group(tree, vectors.velocity, value.velocity)
	tree:add_le(field_map.target, value.target_range, value.target)
	tree:add(field_map.flags1, value.flags1_range, value.flags1)
	tree:add(field_map.flags2, value.flags2_range, value.flags2)
end

---@param tree TreeItem
---@param field_map table
---@param value TerrariaNpcUpdate
---@return nil
local function add_npc_update_ai(tree, field_map, value)
	local ai = value.ai_range and tree:add(field_map.ai_group, value.ai_range) or nil

	if ai then
		for index = 1, 4 do
			if value.ai[index] then
				ai:add_le(field_map.ai[index], value.ai_ranges[index], value.ai[index])
			end
		end
	end
end

---@param tree TreeItem
---@param field_map table
---@param value TerrariaNpcUpdate
---@return nil
local function add_npc_update_life(tree, field_map, value)
	local life = value.life_group_range and tree:add(field_map.life_group, value.life_group_range) or nil

	if life then
		life:add(field_map.life_bytes, value.life_bytes_range, value.life_bytes)

		if value.life then
			if value.life_bytes == 1 then
				life:add(field_map.life, value.life_range, value.life)
			else
				life:add_le(field_map.life, value.life_range, value.life)
			end
		end

		if value.life_raw_range then
			life:add(field_map.life_raw, value.life_raw_range)
		end
	end
end

---@param tree TreeItem
---@param field_map table
---@param value TerrariaNpcUpdate
---@return nil
local function add_npc_update_optional(tree, field_map, value)
	tree:add_le(field_map.npc_net_id, value.npc_net_id_range, value.npc_net_id)

	if value.difficulty_player_count_range then
		tree:add(
			field_map.difficulty_player_count,
			value.difficulty_player_count_range,
			value.difficulty_player_count
		)
	end

	if value.strength_multiplier_range then
		tree:add_le(
			field_map.strength_multiplier,
			value.strength_multiplier_range,
			value.strength_multiplier
		)
	end

	add_npc_update_life(tree, field_map, value)

	if value.release_owner_range then
		tree:add(field_map.release_owner, value.release_owner_range, value.release_owner)
	end
end

---@param payload PayloadReader
---@return nil
local function build(payload)
	local value, range = npc_update_reader.new(payload.reader):read()
	local tree = payload.tree:add(field_map.root, range)

	add_npc_update_base(tree, field_map, value)
	add_npc_update_ai(tree, field_map, value)
	add_npc_update_optional(tree, field_map, value)
end

return {
	id = 23,
	build = build,
	fields = fields,
}
