local color_reader = require("terraria.packet.readers.color_reader")
local network_text_reader = require("terraria.packet.readers.network_text_reader")
local string_reader = require("terraria.packet.readers.string_reader")
local update_player_reader = require("terraria.packet.readers.update_player_reader")

---@class UpdatePlayerFields
---@field player_id ProtoField
---@field control ProtoField
---@field pulley ProtoField
---@field misc ProtoField
---@field sleeping_info ProtoField
---@field selected_item ProtoField
---@field position_x ProtoField
---@field position_y ProtoField
---@field velocity_x ProtoField
---@field velocity_y ProtoField
---@field original_position_x ProtoField
---@field original_position_y ProtoField
---@field home_position_x ProtoField
---@field home_position_y ProtoField

---@class PayloadReader
---@field reader ByteReader
---@field tree TreeItem
local PayloadReader = {}
PayloadReader.__index = PayloadReader

---@param reader ByteReader
---@param tree TreeItem
---@return PayloadReader
function PayloadReader.new(reader, tree)
	return setmetatable({
		reader = reader,
		tree = tree,
	}, PayloadReader)
end

---@param field ProtoField
---@param start integer
---@param err any
function PayloadReader:fail(field, start, err)
	local range = self.reader:range_from(start)
	local item = self.tree:add(field, range)
	local message = string.format(
		"Failed to read payload field at offset %d: %s",
		start,
		tostring(err)
	)

	item:add_expert_info(
		expert.group.MALFORMED,
		expert.severity.ERROR,
		message
	)

	error(err, 0)
end

---@param field ProtoField
function PayloadReader:string(field)
	local start = self.reader:position()
	local strings = string_reader.new(self.reader)
	local ok, value, range = pcall(strings.read, strings)

	if not ok then
		self:fail(field, start, value)
	end

	self.tree:add(field, range, value)
end

---@param field ProtoField
function PayloadReader:network_text(field)
	local start = self.reader:position()
	local reader = network_text_reader.new(self.reader)
	local ok, value, range = pcall(reader.read, reader)

	if not ok then
		self:fail(field, start, value)
	end

	self.tree:add(field, range, value.text)
end

---@param field ProtoField
function PayloadReader:color(field)
	local reader = color_reader.new(self.reader)
	local _, range = reader:read()
	self.tree:add(field, range)
end

---@param field ProtoField
function PayloadReader:bool(field)
	local value, range = self.reader:bool()
	self.tree:add(field, range, value)
end

---@param field ProtoField
function PayloadReader:uint8(field)
	local value, range = self.reader:uint8()
	self.tree:add(field, range, value)
end

---@param field ProtoField
function PayloadReader:sbyte(field)
	local value, range = self.reader:sbyte()
	self.tree:add(field, range, value)
end

---@param field ProtoField
function PayloadReader:uint16_le(field)
	local value, range = self.reader:uint16_le()
	self.tree:add_le(field, range, value)
end

---@param field ProtoField
function PayloadReader:int16_le(field)
	local value, range = self.reader:int16_le()
	self.tree:add_le(field, range, value)
end

---@param field ProtoField
function PayloadReader:uint32_le(field)
	local value, range = self.reader:uint32_le()
	self.tree:add_le(field, range, value)
end

---@param field ProtoField
function PayloadReader:int32_le(field)
	local value, range = self.reader:int32_le()
	self.tree:add_le(field, range, value)
end

---@param field ProtoField
function PayloadReader:uint64_le(field)
	local value, range = self.reader:uint64_le()
	self.tree:add_le(field, range, value)
end

---@param field ProtoField
function PayloadReader:single_le(field)
	local value, range = self.reader:single_le()
	self.tree:add_le(field, range, value)
end

---@param field ProtoField
---@param len integer
function PayloadReader:bytes(field, len)
	local value, range = self.reader:bytes(len)
	self.tree:add(field, range, value)
end

---@param field ProtoField
function PayloadReader:remaining_bytes(field)
	self:bytes(field, self.reader:remaining())
end

---@param fields UpdatePlayerFields
function PayloadReader:update_player(fields)
	local reader = update_player_reader.new(self.reader)
	local value = reader:read()

	self:add_update_player_base(fields, value)
	self:add_optional_vector(fields.velocity_x, fields.velocity_y, value.velocity)
	self:add_optional_vector(
		fields.original_position_x,
		fields.original_position_y,
		value.original_position
	)
	self:add_optional_vector(
		fields.home_position_x,
		fields.home_position_y,
		value.home_position
	)
end

---@param fields UpdatePlayerFields
---@param value TerrariaUpdatePlayer
function PayloadReader:add_update_player_base(fields, value)
	self.tree:add(fields.player_id, value.player_id_range, value.player_id)
	self.tree:add(fields.control, value.control_range, value.control)
	self.tree:add(fields.pulley, value.pulley_range, value.pulley)
	self.tree:add(fields.misc, value.misc_range, value.misc)
	self.tree:add(fields.sleeping_info, value.sleeping_info_range, value.sleeping_info)
	self.tree:add(fields.selected_item, value.selected_item_range, value.selected_item)
	self.tree:add_le(fields.position_x, value.position.x_range, value.position.x)
	self.tree:add_le(fields.position_y, value.position.y_range, value.position.y)
end

---@param x_field ProtoField
---@param y_field ProtoField
---@param vector TerrariaRangedVector2?
function PayloadReader:add_optional_vector(x_field, y_field, vector)
	if not vector then
		return
	end

	self.tree:add_le(x_field, vector.x_range, vector.x)
	self.tree:add_le(y_field, vector.y_range, vector.y)
end

return PayloadReader
