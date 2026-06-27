local color_reader = require("terraria.packet.readers.color_reader")
local network_text_reader = require("terraria.packet.readers.network_text_reader")
local string_reader = require("terraria.packet.readers.string_reader")

local M = {}

---@param tree TreeItem?
---@param field ProtoField
---@param range TvbRange?
---@param value any?
local function add_tree_field(tree, field, range, value)
	if not tree or not range then
		return
	end

	if value == nil then
		tree:add(field, range)
	else
		tree:add(field, range, value)
	end
end

---@param tree TreeItem?
---@param field ProtoField
---@param range TvbRange?
---@param value any?
local function add_tree_le_field(tree, field, range, value)
	if not tree or not range then
		return
	end

	if value == nil then
		tree:add_le(field, range)
	else
		tree:add_le(field, range, value)
	end
end

---@param field ProtoField
---@param range TvbRange?
---@param value any?
function M:add_field(field, range, value)
	add_tree_field(self.tree, field, range, value)
end

---@param field ProtoField
---@param range TvbRange?
---@param value any?
function M:add_le_field(field, range, value)
	add_tree_le_field(self.tree, field, range, value)
end

---@param field ProtoField
---@param start integer
---@param err any
function M:fail(field, start, err)
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
function M:string(field)
	local start = self.reader:position()
	local strings = string_reader.new(self.reader)
	local ok, value, range = pcall(strings.read, strings)

	if not ok then
		self:fail(field, start, value)
	end

	self:add_field(field, range, value)
end

---@param field ProtoField
function M:network_text(field)
	local start = self.reader:position()
	local reader = network_text_reader.new(self.reader)
	local ok, value, range = pcall(reader.read, reader)

	if not ok then
		self:fail(field, start, value)
	end

	self:add_field(field, range, value.text)
end

---@param field ProtoField
function M:color(field)
	local reader = color_reader.new(self.reader)
	local _, range = reader:read()
	self:add_field(field, range)
end

---@param field ProtoField
function M:bool(field)
	local value, range = self.reader:bool()
	self:add_field(field, range, value)
end

---@param field ProtoField
function M:uint8(field)
	local value, range = self.reader:uint8()
	self:add_field(field, range, value)
end

---@param field ProtoField
function M:sbyte(field)
	local value, range = self.reader:sbyte()
	self:add_field(field, range, value)
end

---@param field ProtoField
function M:uint16_le(field)
	local value, range = self.reader:uint16_le()
	self:add_le_field(field, range, value)
end

---@param field ProtoField
function M:int16_le(field)
	local value, range = self.reader:int16_le()
	self:add_le_field(field, range, value)
end

---@param field ProtoField
function M:uint32_le(field)
	local value, range = self.reader:uint32_le()
	self:add_le_field(field, range, value)
end

---@param field ProtoField
function M:int32_le(field)
	local value, range = self.reader:int32_le()
	self:add_le_field(field, range, value)
end

---@param field ProtoField
function M:uint64_le(field)
	local value, range = self.reader:uint64_le()
	self:add_le_field(field, range, value)
end

---@param field ProtoField
function M:single_le(field)
	local value, range = self.reader:single_le()
	self:add_le_field(field, range, value)
end

---@param field ProtoField
---@param len integer
function M:bytes(field, len)
	local value, range = self.reader:bytes(len)
	self:add_field(field, range, value)
end

---@param field ProtoField
function M:remaining_bytes(field)
	self:bytes(field, self.reader:remaining())
end

return M
