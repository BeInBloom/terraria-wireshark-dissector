---@alias PayloadTreeBuilder fun(ctx: PacketContext, tree: TreeItem)

local M = {}

---@class PayloadDissector
---@field fields TerrariaFields
---@field builder_list table<integer, PayloadTreeBuilder>
local PayloadDissector = {}
PayloadDissector.__index = PayloadDissector

---@param fields TerrariaFields
---@return PayloadDissector
function M.new(fields)
	return setmetatable({
		fields = fields,
		builder_list = {},
	}, PayloadDissector)
end

---@param ctx PacketContext
---@param tree TreeItem
function PayloadDissector:dissect(ctx, tree)
	local builder = self:get_builder(ctx.id)
	if builder then
		builder(ctx, tree)
	else
		self:unknown_packet_builder(ctx, tree)
	end
end

---@param packet_id integer
---@return PayloadTreeBuilder
function PayloadDissector:get_builder(packet_id)
	return self.builder_list[packet_id]
end

---@param ctx PacketContext
---@param tree TreeItem
function PayloadDissector:unknown_packet_builder(ctx, tree)
	tree:add_proto_expert_info(
		self.fields.experts,
		string.format("Payload decoder is not registered for packet id=%d", ctx.id)
	)
end

return M
