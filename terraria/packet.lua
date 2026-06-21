local M = {}

local PACKET_LEN = 2
local PAYLOAD_TYPE_LEN = 1
local HEADER_LEN = PACKET_LEN + PAYLOAD_TYPE_LEN

local MAX_PACKET_ID = 140

---@class PduDissector
---@field proto Proto
---@field fields TerrariaFields
local PduDissector = {}
PduDissector.__index = PduDissector

---@param proto Proto
---@param fields TerrariaFields
---@return PduDissector
function PduDissector.new(proto, fields)
	return setmetatable({
		proto = proto,
		fields = fields,
	}, PduDissector)
end

---@param tvb Tvb
---@param _ PInfo
---@param offset integer
---@return integer
local function get_pdu_len(tvb, _, offset)
	return tvb(offset, PACKET_LEN):le_uint()
end

---@param subtree TreeItem
---@param tvb Tvb
function PduDissector:add_header(subtree, tvb)
	subtree:add_le(self.fields.length, tvb(0, PACKET_LEN))
	subtree:add(self.fields.packet_id, tvb(PACKET_LEN, PAYLOAD_TYPE_LEN))
end

---@param subtree TreeItem
---@param tvb Tvb
---@param payload_len integer
function PduDissector:add_raw_payload(subtree, tvb, payload_len)
	if payload_len > 0 then
		subtree:add(self.fields.payload, tvb(HEADER_LEN, payload_len))
	end
end

---@param tvb Tvb
---@param pinfo PInfo
---@param tree TreeItem
---@return integer
function PduDissector:dissect(tvb, pinfo, tree)
	local len = tvb(0, PACKET_LEN):le_uint()
	local id = tvb(PACKET_LEN, PAYLOAD_TYPE_LEN):uint()
	local payload_len = len - HEADER_LEN

	---@diagnostic disable-next-line: inject-field
	pinfo.cols.protocol = "Terraria"

	if len < HEADER_LEN then
		---@diagnostic disable-next-line: inject-field
		pinfo.cols.info = string.format("Malformed packet id=%d len=%d", id, len)

		local subtree = tree:add(self.proto, tvb(), "Terraria Malformed Packet")
		self:add_header(subtree, tvb)

		return len
	end

	if id > MAX_PACKET_ID then
		---@diagnostic disable-next-line: inject-field
		pinfo.cols.info = string.format("Unknown packet id=%d len=%d", id, len)

		local subtree = tree:add(self.proto, tvb(), "Terraria Unknown Packet")
		self:add_header(subtree, tvb)
		self:add_raw_payload(subtree, tvb, payload_len)

		return len
	end

	---@diagnostic disable-next-line: inject-field
	pinfo.cols.info = string.format("Terraria packet id=%d len=%d", id, len)

	local subtree = tree:add(self.proto, tvb(), "Terraria Packet")
	self:add_header(subtree, tvb)

	if payload_len > 0 then
		error("TODO: decode payload and attach payload tree")
	end

	return len
end

---@param proto Proto
---@param fields TerrariaFields
---@return fun(tvb: Tvb, pinfo: PInfo, tree: TreeItem): integer
local function make_pdu_dissector(proto, fields)
	local dissector = PduDissector.new(proto, fields)

	return function(tvb, pinfo, tree)
		return dissector:dissect(tvb, pinfo, tree)
	end
end

---@param proto Proto
---@param fields TerrariaFields
---@param tvb Tvb
---@param tree TreeItem
function M.dissect_tcp_stream(proto, fields, tvb, tree)
	dissect_tcp_pdus(
		tvb,
		tree,
		HEADER_LEN,
		get_pdu_len,
		make_pdu_dissector(proto, fields),
		true
	)
end

return M
