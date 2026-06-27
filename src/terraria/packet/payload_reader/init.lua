local base = require("terraria.packet.payload_reader.base")
local groups = require("terraria.packet.payload_reader.groups")

---@class PayloadReader
---@field reader ByteReader
---@field tree TreeItem
---@field add_field fun(self: PayloadReader, field: ProtoField, range: TvbRange?, value: any?)
---@field add_le_field fun(self: PayloadReader, field: ProtoField, range: TvbRange?, value: any?)
---@field fail fun(self: PayloadReader, field: ProtoField, start: integer, err: any)
---@field string fun(self: PayloadReader, field: ProtoField)
---@field network_text fun(self: PayloadReader, field: ProtoField)
---@field color fun(self: PayloadReader, field: ProtoField)
---@field bool fun(self: PayloadReader, field: ProtoField)
---@field uint8 fun(self: PayloadReader, field: ProtoField)
---@field sbyte fun(self: PayloadReader, field: ProtoField)
---@field uint16_le fun(self: PayloadReader, field: ProtoField)
---@field int16_le fun(self: PayloadReader, field: ProtoField)
---@field uint32_le fun(self: PayloadReader, field: ProtoField)
---@field int32_le fun(self: PayloadReader, field: ProtoField)
---@field uint64_le fun(self: PayloadReader, field: ProtoField)
---@field single_le fun(self: PayloadReader, field: ProtoField)
---@field bytes fun(self: PayloadReader, field: ProtoField, len: integer)
---@field remaining_bytes fun(self: PayloadReader, field: ProtoField)
---@field group fun(self: PayloadReader, field: ProtoField, read: fun(payload: PayloadReader))
local PayloadReader = {}
PayloadReader.__index = PayloadReader

for _, module in ipairs({ base, groups }) do
	for name, fn in pairs(module) do
		PayloadReader[name] = fn
	end
end

---@param reader ByteReader
---@param tree TreeItem
---@return PayloadReader
function PayloadReader.new(reader, tree)
	return setmetatable({
		reader = reader,
		tree = tree,
	}, PayloadReader)
end

return PayloadReader
