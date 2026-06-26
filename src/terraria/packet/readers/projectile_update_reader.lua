local M = {}

local AI0 = 0x01
local AI1 = 0x02
local DAMAGE = 0x10
local KNOCKBACK = 0x20
local ORIGINAL_DAMAGE = 0x40
local PROJECTILE_UUID = 0x80

---@class ProjectileUpdateReader
---@field reader ByteReader
local ProjectileUpdateReader = {}
ProjectileUpdateReader.__index = ProjectileUpdateReader

---@param reader ByteReader
---@return ProjectileUpdateReader
function M.new(reader)
	return setmetatable({
		reader = reader,
	}, ProjectileUpdateReader)
end

---@return TerrariaRangedVector2
function ProjectileUpdateReader:read_vector()
	local start = self.reader:position()
	local x, x_range = self.reader:single_le()
	local y, y_range = self.reader:single_le()

	return {
		x = x,
		y = y,
		range = self.reader:range_from(start),
		x_range = x_range,
		y_range = y_range,
	}
end

---@return TerrariaProjectileUpdate
function ProjectileUpdateReader:read_base()
	local value = {}

	value.projectile_id, value.projectile_id_range = self.reader:int16_le()
	value.position = self:read_vector()
	value.velocity = self:read_vector()
	value.owner, value.owner_range = self.reader:uint8()
	value.projectile_type, value.projectile_type_range = self.reader:int16_le()
	value.flags, value.flags_range = self.reader:uint8()

	return value
end

---@param value TerrariaProjectileUpdate
function ProjectileUpdateReader:read_ai(value)
	local start = self.reader:position()

	if (value.flags & AI0) ~= 0 then
		value.ai0, value.ai0_range = self.reader:single_le()
	end
	if (value.flags & AI1) ~= 0 then
		value.ai1, value.ai1_range = self.reader:single_le()
	end

	if self.reader:position() > start then
		value.ai_range = self.reader:range_from(start)
	end
end

---@param value TerrariaProjectileUpdate
function ProjectileUpdateReader:read_stats(value)
	if (value.flags & DAMAGE) ~= 0 then
		value.damage, value.damage_range = self.reader:int16_le()
	end
	if (value.flags & KNOCKBACK) ~= 0 then
		value.knockback, value.knockback_range = self.reader:single_le()
	end
end

---@param value TerrariaProjectileUpdate
function ProjectileUpdateReader:read_stats_group(value)
	local start = self.reader:position()

	self:read_stats(value)
	self:read_original_identity(value)

	if self.reader:position() > start then
		value.stats_range = self.reader:range_from(start)
	end
end

---@param value TerrariaProjectileUpdate
function ProjectileUpdateReader:read_original_identity(value)
	if (value.flags & ORIGINAL_DAMAGE) ~= 0 then
		value.original_damage, value.original_damage_range = self.reader:int16_le()
	end
	if (value.flags & PROJECTILE_UUID) ~= 0 then
		value.projectile_uuid, value.projectile_uuid_range = self.reader:int16_le()
	end
end

---@return TerrariaProjectileUpdate
---@return TvbRange
function ProjectileUpdateReader:read()
	local start = self.reader:position()
	local value = self:read_base()

	self:read_ai(value)
	self:read_stats_group(value)

	return value, self.reader:range_from(start)
end

return M
