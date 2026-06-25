local item_data_reader = require("terraria.packet.readers.item_data_reader")

local M = {}

---@class TileEntityExtraReader
---@field reader ByteReader
---@field entity_type integer
---@field items ItemDataReader
local TileEntityExtraReader = {}
TileEntityExtraReader.__index = TileEntityExtraReader

---@param reader ByteReader
---@param entity_type integer
---@return TileEntityExtraReader
function M.new(reader, entity_type)
	return setmetatable({
		reader = reader,
		entity_type = entity_type,
		items = item_data_reader.new(reader),
	}, TileEntityExtraReader)
end

---@return TerrariaTrainingDummyData
function TileEntityExtraReader:read_training_dummy()
	local npc_index, npc_index_range = self.reader:int16_le()
	return {
		npc_index = npc_index,
		npc_index_range = npc_index_range,
	}
end

---@return TerrariaLogicSensorData
function TileEntityExtraReader:read_logic_sensor()
	local check_type, check_type_range = self.reader:uint8()
	local on, on_range = self.reader:bool()
	return {
		logic_check_type = check_type,
		on = on,
		logic_check_type_range = check_type_range,
		on_range = on_range,
	}
end

---@param flags integer
---@param first_bit integer
---@param count integer
---@return TerrariaItemData[]
---@return TvbRange[]
function TileEntityExtraReader:read_slots(flags, first_bit, count)
	local values = {}
	local ranges = {}

	for slot = 1, count do
		if (flags & (1 << (first_bit + slot - 1))) ~= 0 then
			values[slot], ranges[slot] = self.items:read()
		end
	end

	return values, ranges
end

---@return TerrariaDisplayDollData
function TileEntityExtraReader:read_display_doll()
	local item_flags, item_flags_range = self.reader:uint8()
	local dye_flags, dye_flags_range = self.reader:uint8()
	local items, item_ranges = self:read_slots(item_flags, 0, 8)
	local dyes, dye_ranges = self:read_slots(dye_flags, 0, 8)

	return {
		item_flags = item_flags,
		dye_flags = dye_flags,
		items = items,
		dyes = dyes,
		item_ranges = item_ranges,
		dye_ranges = dye_ranges,
		item_flags_range = item_flags_range,
		dye_flags_range = dye_flags_range,
	}
end

---@return TerrariaHatRackData
function TileEntityExtraReader:read_hat_rack()
	local flags, flags_range = self.reader:uint8()
	local items, item_ranges = self:read_slots(flags, 0, 2)
	local dyes, dye_ranges = self:read_slots(flags, 2, 2)

	return {
		flags = flags,
		items = items,
		dyes = dyes,
		item_ranges = item_ranges,
		dye_ranges = dye_ranges,
		flags_range = flags_range,
	}
end

---@return TerrariaTileEntityExtraData
function TileEntityExtraReader:read_value()
	if self.entity_type == 0 then
		return self:read_training_dummy()
	elseif self.entity_type == 1 or self.entity_type == 4 or self.entity_type == 6 then
		local item = self.items:read()
		return item
	elseif self.entity_type == 2 then
		return self:read_logic_sensor()
	elseif self.entity_type == 3 then
		return self:read_display_doll()
	elseif self.entity_type == 5 then
		return self:read_hat_rack()
	elseif self.entity_type == 7 then
		return {}
	end

	error(string.format("unsupported tile entity type: %d", self.entity_type))
end

---@return TerrariaTileEntityExtraData
---@return TvbRange
function TileEntityExtraReader:read()
	local start = self.reader:position()
	local value = self:read_value()
	return value, self.reader:range_from(start)
end

return M
