local builders = require("terraria.packet.builders")
local byte_reader = require("terraria.packet.readers.byte_reader")
local payload_reader = require("terraria.packet.payload_reader")

---@alias PayloadBuilder fun(payload: PayloadReader)

local M = {}

---@class PayloadDissector
---@field fields TerrariaFields
---@field builder_list table<integer, PayloadBuilder>
local PayloadDissector = {}
PayloadDissector.__index = PayloadDissector

---@param fields TerrariaFields
---@return PayloadDissector
function M.new(fields)
	return setmetatable({
		fields = fields,
		builder_list = builders,
	}, PayloadDissector)
end

---@param ctx PacketContext
---@param tree TreeItem
function PayloadDissector:dissect(ctx, tree)
	local builder = self:get_builder(ctx.id)
	if not builder then
		self:unknown_packet_builder(ctx, tree)
		return
	end

	local reader = byte_reader.new(ctx:payload_range())
	local payload = payload_reader.new(reader, tree)
	local ok, err = pcall(builder, payload)

	if not ok then
		self:report_malformed_payload(ctx, tree, err)
		return
	end

	self:report_unread_payload(ctx, tree, reader)
end

---@param packet_id integer
---@return PayloadBuilder?
function PayloadDissector:get_builder(packet_id)
	return self.builder_list[packet_id]
end

---@param ctx PacketContext
---@param tree TreeItem
function PayloadDissector:unknown_packet_builder(ctx, tree)
	tree:add_proto_expert_info(
		self.fields.missing_builder,
		string.format("Payload decoder is not registered for packet id=%d", ctx.id)
	)
end

---@param ctx PacketContext
---@param tree TreeItem
---@param err any
function PayloadDissector:report_malformed_payload(ctx, tree, err)
	tree:add_proto_expert_info(
		self.fields.malformed_payload,
		string.format("Failed to decode payload for packet id=%d: %s", ctx.id, tostring(err))
	)
end

---@param ctx PacketContext
---@param tree TreeItem
---@param reader ByteReader
function PayloadDissector:report_unread_payload(ctx, tree, reader)
	local remaining = reader:remaining()
	if remaining == 0 then
		return
	end

	local range = reader:range(remaining)
	local item = tree:add(self.fields.unread_payload, range)
	item:add_proto_expert_info(
		self.fields.unread_payload_expert,
		string.format("Packet id=%d has %d unread payload byte(s)", ctx.id, remaining)
	)
end

return M
