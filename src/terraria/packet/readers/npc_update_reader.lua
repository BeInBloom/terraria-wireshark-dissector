local M = {}

local AI0 = 0x04
local AI1 = 0x08
local AI2 = 0x10
local AI3 = 0x20
local LIFE_MAX = 0x80
local STATS_SCALED = 0x01
local STRENGTH_MULTIPLIER = 0x04

---@class NpcUpdateReader
---@field reader ByteReader
local NpcUpdateReader = {}
NpcUpdateReader.__index = NpcUpdateReader

---@param reader ByteReader
---@return NpcUpdateReader
function M.new(reader)
	return setmetatable({
		reader = reader,
	}, NpcUpdateReader)
end

---@return TerrariaRangedVector2
function NpcUpdateReader:read_vector()
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

---@return TerrariaNpcUpdate
function NpcUpdateReader:read_base()
	local value = {}

	value.npc_id, value.npc_id_range = self.reader:int16_le()
	value.position = self:read_vector()
	value.velocity = self:read_vector()
	value.target, value.target_range = self.reader:uint16_le()
	value.flags1, value.flags1_range = self.reader:uint8()
	value.flags2, value.flags2_range = self.reader:uint8()

	return value
end

---@param value TerrariaNpcUpdate
---@param index integer
---@param flag integer
function NpcUpdateReader:read_ai_value(value, index, flag)
	if (value.flags1 & flag) == 0 then
		return
	end

	value.ai[index], value.ai_ranges[index] = self.reader:single_le()
end

---@param value TerrariaNpcUpdate
function NpcUpdateReader:read_ai(value)
	local start = self.reader:position()
	value.ai = {}
	value.ai_ranges = {}

	self:read_ai_value(value, 1, AI0)
	self:read_ai_value(value, 2, AI1)
	self:read_ai_value(value, 3, AI2)
	self:read_ai_value(value, 4, AI3)

	if self.reader:position() > start then
		value.ai_range = self.reader:range_from(start)
	end
end

---@param value TerrariaNpcUpdate
function NpcUpdateReader:read_life_value(value)
	if value.life_bytes == 1 then
		value.life, value.life_range = self.reader:uint8()
	elseif value.life_bytes == 2 then
		value.life, value.life_range = self.reader:int16_le()
	elseif value.life_bytes == 4 then
		value.life, value.life_range = self.reader:int32_le()
	elseif value.life_bytes > 0 then
		value.life_raw, value.life_raw_range = self.reader:bytes(value.life_bytes)
	end
end

---@param value TerrariaNpcUpdate
function NpcUpdateReader:read_life(value)
	if (value.flags1 & LIFE_MAX) ~= 0 then
		return
	end

	local start = self.reader:position()
	value.life_bytes, value.life_bytes_range = self.reader:uint8()
	self:read_life_value(value)
	value.life_group_range = self.reader:range_from(start)
end

---@param value TerrariaNpcUpdate
function NpcUpdateReader:read_optional(value)
	self:read_ai(value)
	value.npc_net_id, value.npc_net_id_range = self.reader:int16_le()

	if (value.flags2 & STATS_SCALED) ~= 0 then
		value.difficulty_player_count, value.difficulty_player_count_range = self.reader:uint8()
	end
	if (value.flags2 & STRENGTH_MULTIPLIER) ~= 0 then
		value.strength_multiplier, value.strength_multiplier_range = self.reader:single_le()
	end

	self:read_life(value)
end

---@param value TerrariaNpcUpdate
function NpcUpdateReader:read_release_owner(value)
	if self.reader:remaining() > 0 then
		value.release_owner, value.release_owner_range = self.reader:uint8()
	end
end

---@return TerrariaNpcUpdate
---@return TvbRange
function NpcUpdateReader:read()
	local start = self.reader:position()
	local value = self:read_base()

	self:read_optional(value)
	self:read_release_owner(value)

	return value, self.reader:range_from(start)
end

return M
