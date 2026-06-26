local pd = require("terraria.packet.payload_dissector")
local context = require("terraria.packet.context")
local packet_catalog = require("terraria.packet.packet_catalog")

local M = {}

---@class TerrariaDissector
---@field proto Proto
---@field fields TerrariaFields
---@field payload_dissector PayloadDissector
---@field pdu_dissector fun(tvb: Tvb, pinfo: PInfo, tree: TreeItem): integer
local TerrariaDissector = {}
TerrariaDissector.__index = TerrariaDissector

---@param proto Proto
---@param fields TerrariaFields
---@return TerrariaDissector
function M.new(proto, fields)
	local payload_dissector = pd.new(fields)

	local self = setmetatable({
		proto = proto,
		fields = fields,
		payload_dissector = payload_dissector,
	}, TerrariaDissector)

	self.pdu_dissector = function(tvb, pinfo, tree)
		return self:dissect_pdu(tvb, pinfo, tree)
	end

	return self
end

---@param ctx PacketContext
---@return boolean
function TerrariaDissector:is_unknown(ctx)
	return packet_catalog[ctx.id] == nil
end

---@param ctx PacketContext
---@param subtree TreeItem
function TerrariaDissector:add_header(ctx, subtree)
	subtree:add_le(self.fields.length, ctx:length_range())
	subtree:add(self.fields.packet_id, ctx:id_range())
end

---@param ctx PacketContext
---@param subtree TreeItem
function TerrariaDissector:add_raw_payload(ctx, subtree)
	if ctx.payload_len > 0 then
		subtree:add(self.fields.payload, ctx:payload_range())
	end
end

---@param ctx PacketContext
---@param title string
---@param tree TreeItem
---@return TreeItem
function TerrariaDissector:add_packet_tree(ctx, title, tree)
	local subtree = tree:add(self.proto, ctx:full_range(), title)
	self:add_header(ctx, subtree)
	return subtree
end

---@param ctx PacketContext
---@param pinfo PInfo
---@param tree TreeItem
---@return integer
function TerrariaDissector:dissect_malformed(ctx, pinfo, tree)
	---@diagnostic disable-next-line: inject-field
	pinfo.cols.info = string.format("Malformed packet id=%d len=%d", ctx.id, ctx.len)
	self:add_packet_tree(ctx, "Terraria Malformed Packet", tree)
	return ctx.len
end

---@param ctx PacketContext
---@param pinfo PInfo
---@param tree TreeItem
---@return integer
function TerrariaDissector:dissect_unknown(ctx, pinfo, tree)
	---@diagnostic disable-next-line: inject-field
	pinfo.cols.info = string.format("Unknown packet id=%d len=%d", ctx.id, ctx.len)
	local subtree = self:add_packet_tree(ctx, "Terraria Unknown Packet", tree)
	self:add_raw_payload(ctx, subtree)
	return ctx.len
end

---@param ctx PacketContext
---@param pinfo PInfo
---@param tree TreeItem
---@return integer
function TerrariaDissector:dissect_known(ctx, pinfo, tree)
	local packet = packet_catalog[ctx.id]

	---@diagnostic disable-next-line: inject-field
	pinfo.cols.info = string.format(
		"Terraria %s id=%d len=%d",
		packet.name,
		ctx.id,
		ctx.len
	)

	local subtree = self:add_packet_tree(ctx, "Terraria " .. packet.name, tree)

	local has_builder = self.payload_dissector:get_builder(ctx.id) ~= nil
	if ctx.payload_len > 0 or has_builder then
		local payload_tree = subtree:add(self.fields.payload, ctx:payload_range())
		payload_tree:set_text("Payload")

		self.payload_dissector:dissect(ctx, payload_tree)
	end

	return ctx.len
end

---@param tvb Tvb
---@param pinfo PInfo
---@param tree TreeItem
---@return integer
function TerrariaDissector:dissect_pdu(tvb, pinfo, tree)
	---@diagnostic disable-next-line: inject-field
	pinfo.cols.protocol = "Terraria"

	local ctx = context.new(tvb)

	if ctx:is_malformed() then
		return self:dissect_malformed(ctx, pinfo, tree)
	end

	if self:is_unknown(ctx) then
		return self:dissect_unknown(ctx, pinfo, tree)
	end

	return self:dissect_known(ctx, pinfo, tree)
end

---@param tvb Tvb
---@param _ PInfo
---@param tree TreeItem
function TerrariaDissector:dissect(tvb, _, tree)
	dissect_tcp_pdus(
		tvb,
		tree,
		context.header_size(),
		context.pdu_len,
		self.pdu_dissector,
		true
	)
end

return M
