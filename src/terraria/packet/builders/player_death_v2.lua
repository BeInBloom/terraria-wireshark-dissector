local player_id = ProtoField.uint8("terraria.player_death_v2.player_id", "Player ID", base.DEC)
local death_reason = ProtoField.bytes("terraria.player_death_v2.death_reason", "Death Reason")
local death_reason_flags = ProtoField.uint8(
	"terraria.player_death_v2.death_reason_flags",
	"Death Reason Flags",
	base.HEX
)
local killer_player_id = ProtoField.int16(
	"terraria.player_death_v2.killer_player_id",
	"Killer Player ID",
	base.DEC
)
local killer_npc_index = ProtoField.int16(
	"terraria.player_death_v2.killer_npc_index",
	"Killer NPC Index",
	base.DEC
)
local projectile_index = ProtoField.int16(
	"terraria.player_death_v2.projectile_index",
	"Projectile Index",
	base.DEC
)
local other_death_type = ProtoField.uint8(
	"terraria.player_death_v2.other_death_type",
	"Other Death Type",
	base.DEC
)
local projectile_type = ProtoField.int16(
	"terraria.player_death_v2.projectile_type",
	"Projectile Type",
	base.DEC
)
local item_type = ProtoField.int16(
	"terraria.player_death_v2.item_type",
	"Item Type",
	base.DEC
)
local item_prefix = ProtoField.uint8(
	"terraria.player_death_v2.item_prefix",
	"Item Prefix",
	base.DEC
)
local custom_reason = ProtoField.string(
	"terraria.player_death_v2.custom_reason",
	"Death Reason Text"
)
local damage = ProtoField.int16("terraria.player_death_v2.damage", "Damage", base.DEC)
local hit_direction = ProtoField.uint8(
	"terraria.player_death_v2.hit_direction",
	"Hit Direction",
	base.DEC
)
local flags = ProtoField.uint8("terraria.player_death_v2.flags", "Flags", base.HEX)
local player_death_reason_reader = require("terraria.packet.readers.player_death_reason_reader")

local function add_reason_fields(tree, value, payload)
	payload:add_tree_field(tree, death_reason_flags, value.flags_range, value.flags)
	payload:add_tree_field(tree, killer_player_id, value.killer_player_id_range, value.killer_player_id)
	payload:add_tree_field(tree, killer_npc_index, value.killer_npc_index_range, value.killer_npc_index)
	payload:add_tree_field(tree, projectile_index, value.projectile_index_range, value.projectile_index)
	payload:add_tree_field(tree, other_death_type, value.other_death_type_range, value.other_death_type)
	payload:add_tree_field(tree, projectile_type, value.projectile_type_range, value.projectile_type)
	payload:add_tree_field(tree, item_type, value.item_type_range, value.item_type)
	payload:add_tree_field(tree, item_prefix, value.item_prefix_range, value.item_prefix)
	payload:add_tree_field(tree, custom_reason, value.custom_reason_range, value.custom_reason)
end

---@param payload PayloadReader
local function build_death_reason(payload)
	local value = player_death_reason_reader.new(payload.reader):read()
	add_reason_fields(payload.tree, value, payload)
end

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:group(death_reason, "Death Reason", build_death_reason)
	payload:int16_le(damage)
	payload:uint8(hit_direction)
	payload:uint8(flags)
end

return {
	id = 118,
	build = build,
	fields = {
		player_id,
		death_reason,
		death_reason_flags,
		killer_player_id,
		killer_npc_index,
		projectile_index,
		other_death_type,
		projectile_type,
		item_type,
		item_prefix,
		custom_reason,
		damage,
		hit_direction,
		flags,
	},
}
