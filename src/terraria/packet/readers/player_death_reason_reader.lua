local string_reader = require("terraria.packet.readers.string_reader")

local M = {}

local KILLER_PLAYER = 0x01
local KILLER_NPC = 0x02
local KILLER_PROJECTILE = 0x04
local OTHER_DEATH = 0x08
local PROJECTILE_TYPE = 0x10
local ITEM_TYPE = 0x20
local ITEM_PREFIX = 0x40
local CUSTOM_REASON = 0x80

---@class PlayerDeathReasonReader
---@field reader ByteReader
---@field strings StringReader
local PlayerDeathReasonReader = {}
PlayerDeathReasonReader.__index = PlayerDeathReasonReader

---@param reader ByteReader
---@return PlayerDeathReasonReader
function M.new(reader)
	return setmetatable({
		reader = reader,
		strings = string_reader.new(reader),
	}, PlayerDeathReasonReader)
end

---@param flags integer
---@param mask integer
---@return integer?
---@return TvbRange?
function PlayerDeathReasonReader:read_int16_if(flags, mask)
	if (flags & mask) == 0 then
		return nil, nil
	end

	return self.reader:int16_le()
end

---@param flags integer
---@param mask integer
---@return integer?
---@return TvbRange?
function PlayerDeathReasonReader:read_uint8_if(flags, mask)
	if (flags & mask) == 0 then
		return nil, nil
	end

	return self.reader:uint8()
end

---@param flags integer
---@return string?
---@return TvbRange?
function PlayerDeathReasonReader:read_reason_if_present(flags)
	if (flags & CUSTOM_REASON) == 0 then
		return nil, nil
	end

	return self.strings:read()
end

---@param flags integer
---@return TerrariaPlayerDeathReason
function PlayerDeathReasonReader:read_fields(flags)
	local value = {}
	value.killer_player_id, value.killer_player_id_range = self:read_int16_if(flags, KILLER_PLAYER)
	value.killer_npc_index, value.killer_npc_index_range = self:read_int16_if(flags, KILLER_NPC)
	value.projectile_index, value.projectile_index_range = self:read_int16_if(flags, KILLER_PROJECTILE)
	value.other_death_type, value.other_death_type_range = self:read_uint8_if(flags, OTHER_DEATH)
	value.projectile_type, value.projectile_type_range = self:read_int16_if(flags, PROJECTILE_TYPE)
	value.item_type, value.item_type_range = self:read_int16_if(flags, ITEM_TYPE)
	value.item_prefix, value.item_prefix_range = self:read_uint8_if(flags, ITEM_PREFIX)
	value.custom_reason, value.custom_reason_range = self:read_reason_if_present(flags)
	return value
end

---@return TerrariaPlayerDeathReason
---@return TvbRange
function PlayerDeathReasonReader:read()
	local start = self.reader:position()
	local flags, flags_range = self.reader:uint8()
	local value = self:read_fields(flags)

	value.flags = flags
	value.flags_range = flags_range

	return value, self.reader:range_from(start)
end

return M
