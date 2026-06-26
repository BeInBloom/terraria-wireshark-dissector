local registered_fields = {}

local function define(factory, name, label, display)
	local field = factory("terraria.projectile_update." .. name, label, display)
	registered_fields[#registered_fields + 1] = field
	return field
end

local fields = {
	projectile_id = define(ProtoField.int16, "projectile_id", "Projectile ID", base.DEC),
	position_x = define(ProtoField.float, "position_x", "Position X"),
	position_y = define(ProtoField.float, "position_y", "Position Y"),
	velocity_x = define(ProtoField.float, "velocity_x", "Velocity X"),
	velocity_y = define(ProtoField.float, "velocity_y", "Velocity Y"),
	owner = define(ProtoField.uint8, "owner", "Owner", base.DEC),
	projectile_type = define(ProtoField.int16, "projectile_type", "Type", base.DEC),
	flags = define(ProtoField.uint8, "flags", "Projectile Flags", base.HEX),
	ai0 = define(ProtoField.float, "ai0", "AI 0"),
	ai1 = define(ProtoField.float, "ai1", "AI 1"),
	damage = define(ProtoField.int16, "damage", "Damage", base.DEC),
	knockback = define(ProtoField.float, "knockback", "Knockback"),
	original_damage = define(ProtoField.int16, "original_damage", "Original Damage", base.DEC),
	projectile_uuid = define(ProtoField.int16, "projectile_uuid", "Projectile UUID", base.DEC),
}

---@param payload PayloadReader
local function build(payload)
	payload:projectile_update(fields)
end

return {
	id = 27,
	build = build,
	fields = registered_fields,
}
