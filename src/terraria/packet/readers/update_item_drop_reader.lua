local M = {}

---@class UpdateItemDropReader
---@field reader ByteReader
local UpdateItemDropReader = {}
UpdateItemDropReader.__index = UpdateItemDropReader

---@param reader ByteReader
---@return UpdateItemDropReader
function M.new(reader)
	return setmetatable({
		reader = reader,
	}, UpdateItemDropReader)
end

---@return TerrariaRangedVector2
function UpdateItemDropReader:read_vector()
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

---@param value TerrariaUpdateItemDrop
function UpdateItemDropReader:read_item(value)
	local start = self.reader:position()

	value.stack_size, value.stack_size_range = self.reader:int16_le()
	value.prefix, value.prefix_range = self.reader:uint8()
	value.no_delay, value.no_delay_range = self.reader:uint8()
	value.item_net_id, value.item_net_id_range = self.reader:int16_le()
	value.item_range = self.reader:range_from(start)
end

---@return TerrariaUpdateItemDrop
---@return TvbRange
function UpdateItemDropReader:read()
	local start = self.reader:position()
	local value = {}

	value.item_id, value.item_id_range = self.reader:int16_le()
	value.position = self:read_vector()
	value.velocity = self:read_vector()
	self:read_item(value)

	return value, self.reader:range_from(start)
end

return M
