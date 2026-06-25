local M = {}

local UPDATE_VELOCITY = 0x04
local USED_POTION_OF_RETURN = 0x40

---@class UpdatePlayerReader
---@field reader ByteReader
local UpdatePlayerReader = {}
UpdatePlayerReader.__index = UpdatePlayerReader

---@param reader ByteReader
---@return UpdatePlayerReader
function M.new(reader)
	return setmetatable({
		reader = reader,
	}, UpdatePlayerReader)
end

---@return TerrariaRangedVector2
function UpdatePlayerReader:read_vector()
	local x, x_range = self.reader:single_le()
	local y, y_range = self.reader:single_le()

	return {
		x = x,
		y = y,
		x_range = x_range,
		y_range = y_range,
	}
end

---@return TerrariaUpdatePlayer
function UpdatePlayerReader:read_header()
	local value = {}
	value.player_id, value.player_id_range = self.reader:uint8()
	value.control, value.control_range = self.reader:uint8()
	value.pulley, value.pulley_range = self.reader:uint8()
	value.misc, value.misc_range = self.reader:uint8()
	value.sleeping_info, value.sleeping_info_range = self.reader:uint8()
	value.selected_item, value.selected_item_range = self.reader:uint8()
	value.position = self:read_vector()
	return value
end

---@param value TerrariaUpdatePlayer
function UpdatePlayerReader:read_optional_fields(value)
	if (value.pulley & UPDATE_VELOCITY) ~= 0 then
		value.velocity = self:read_vector()
	end

	if (value.misc & USED_POTION_OF_RETURN) ~= 0 then
		value.original_position = self:read_vector()
		value.home_position = self:read_vector()
	end
end

---@return TerrariaUpdatePlayer
---@return TvbRange
function UpdatePlayerReader:read()
	local start = self.reader:position()
	local value = self:read_header()
	self:read_optional_fields(value)
	return value, self.reader:range_from(start)
end

return M
