local M = {}

---@class ItemDataReader
---@field reader ByteReader
local ItemDataReader = {}
ItemDataReader.__index = ItemDataReader

---@param reader ByteReader
---@return ItemDataReader
function M.new(reader)
	return setmetatable({
		reader = reader,
	}, ItemDataReader)
end

---@return TerrariaItemData
---@return TvbRange
function ItemDataReader:read()
	local start = self.reader:position()
	local item_type, type_range = self.reader:int16_le()
	local prefix, prefix_range = self.reader:uint8()
	local stack, stack_range = self.reader:int16_le()

	return {
		type = item_type,
		prefix = prefix,
		stack = stack,
		type_range = type_range,
		prefix_range = prefix_range,
		stack_range = stack_range,
	}, self.reader:range_from(start)
end

return M
