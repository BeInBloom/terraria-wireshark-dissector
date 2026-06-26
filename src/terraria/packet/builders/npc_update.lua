local registered_fields = {}

local function define(factory, name, label, display)
	local field = factory("terraria.npc_update." .. name, label, display)
	registered_fields[#registered_fields + 1] = field
	return field
end

local fields = {
	npc_id = define(ProtoField.int16, "npc_id", "NPC ID", base.DEC),
	position_x = define(ProtoField.float, "position_x", "Position X"),
	position_y = define(ProtoField.float, "position_y", "Position Y"),
	velocity_x = define(ProtoField.float, "velocity_x", "Velocity X"),
	velocity_y = define(ProtoField.float, "velocity_y", "Velocity Y"),
	target = define(ProtoField.uint16, "target", "Target", base.DEC),
	flags1 = define(ProtoField.uint8, "flags1", "NPC Flags 1", base.HEX),
	flags2 = define(ProtoField.uint8, "flags2", "NPC Flags 2", base.HEX),
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
	life_bytes = define(ProtoField.uint8, "life_bytes", "Life Bytes", base.DEC),
	life = define(ProtoField.int32, "life", "Life", base.DEC),
	life_raw = define(ProtoField.bytes, "life_raw", "Raw Life"),
	release_owner = define(ProtoField.uint8, "release_owner", "Release Owner", base.DEC),
}

---@param payload PayloadReader
local function build(payload)
	payload:npc_update(fields)
end

return {
	id = 23,
	build = build,
	fields = registered_fields,
}
