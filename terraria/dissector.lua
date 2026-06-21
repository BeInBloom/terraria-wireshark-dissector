local M = {}

local PACKET_LEN = 2
local PACKET_ID_LEN = 1
local HEADER_LEN = PACKET_LEN + PACKET_ID_LEN

local MAX_PACKET_ID = 140

---@class TerrariaDissector
---@field proto Proto
---@field fields TerrariaFields
---@field pdu_dissector fun(tvb: Tvb, pinfo: PInfo, tree: TreeItem): integer
local TerrariaDissector = {}
TerrariaDissector.__index = TerrariaDissector

---@param proto Proto
---@param fields TerrariaFields
---@return TerrariaDissector
function M.new(proto, fields)
	local self = setmetatable({
		proto = proto,
		fields = fields,
	}, TerrariaDissector)

	self.pdu_dissector = function(tvb, pinfo, tree)
		return self:dissect_pdu(tvb, pinfo, tree)
	end

	return self
end

---@param tvb Tvb
---@param _ PInfo
---@param offset integer
---@return integer
local function get_pdu_len(tvb, _, offset)
	return tvb(offset, PACKET_LEN):le_uint()
end

---@param tvb Tvb
---@return integer
function TerrariaDissector:packet_len(tvb)
	return tvb(0, PACKET_LEN):le_uint()
end

---@param tvb Tvb
---@return integer
function TerrariaDissector:packet_id(tvb)
	return tvb(PACKET_LEN, PACKET_ID_LEN):uint()
end

---@param tvb Tvb
---@return integer
function TerrariaDissector:payload_len(tvb)
	return self:packet_len(tvb) - HEADER_LEN
end

---@param tvb Tvb
---@return boolean
function TerrariaDissector:is_malformed(tvb)
	return self:packet_len(tvb) < HEADER_LEN
end

---@param tvb Tvb
---@return boolean
function TerrariaDissector:is_unknown(tvb)
	return self:packet_id(tvb) > MAX_PACKET_ID
end

---@param subtree TreeItem
---@param tvb Tvb
function TerrariaDissector:add_header(subtree, tvb)
	subtree:add_le(self.fields.length, tvb(0, PACKET_LEN))
	subtree:add(self.fields.packet_id, tvb(PACKET_LEN, PACKET_ID_LEN))
end

---@param subtree TreeItem
---@param tvb Tvb
---@param payload_len integer
function TerrariaDissector:add_raw_payload(subtree, tvb, payload_len)
	if payload_len > 0 then
		subtree:add(self.fields.payload, tvb(HEADER_LEN, payload_len))
	end
end

---@param title string
---@param tvb Tvb
---@param tree TreeItem
---@return TreeItem
function TerrariaDissector:add_packet_tree(title, tvb, tree)
	local subtree = tree:add(self.proto, tvb(), title)
	self:add_header(subtree, tvb)
	return subtree
end

---@param tvb Tvb
---@param pinfo PInfo
---@param tree TreeItem
---@return integer
function TerrariaDissector:dissect_malformed(tvb, pinfo, tree)
	local len = self:packet_len(tvb)
	local id = self:packet_id(tvb)

	---@diagnostic disable-next-line: inject-field
	pinfo.cols.info = string.format("Malformed packet id=%d len=%d", id, len)

	self:add_packet_tree("Terraria Malformed Packet", tvb, tree)

	return len
end

---@param tvb Tvb
---@param pinfo PInfo
---@param tree TreeItem
---@return integer
function TerrariaDissector:dissect_unknown(tvb, pinfo, tree)
	local len = self:packet_len(tvb)
	local id = self:packet_id(tvb)
	local payload_len = self:payload_len(tvb)

	---@diagnostic disable-next-line: inject-field
	pinfo.cols.info = string.format("Unknown packet id=%d len=%d", id, len)

	local subtree = self:add_packet_tree("Terraria Unknown Packet", tvb, tree)
	self:add_raw_payload(subtree, tvb, payload_len)

	return len
end

---@param tvb Tvb
---@param pinfo PInfo
---@param tree TreeItem
---@return integer
function TerrariaDissector:dissect_known(tvb, pinfo, tree)
	local len = self:packet_len(tvb)
	local id = self:packet_id(tvb)
	local payload_len = self:payload_len(tvb)

	---@diagnostic disable-next-line: inject-field
	pinfo.cols.info = string.format("Terraria packet id=%d len=%d", id, len)

	self:add_packet_tree("Terraria Packet", tvb, tree)

	if payload_len > 0 then
		error("TODO: decode payload and attach payload tree")
	end

	return len
end

---@param tvb Tvb
---@param pinfo PInfo
---@param tree TreeItem
---@return integer
function TerrariaDissector:dissect_pdu(tvb, pinfo, tree)
	---@diagnostic disable-next-line: inject-field
	pinfo.cols.protocol = "Terraria"

	if self:is_malformed(tvb) then
		return self:dissect_malformed(tvb, pinfo, tree)
	end

	if self:is_unknown(tvb) then
		return self:dissect_unknown(tvb, pinfo, tree)
	end

	return self:dissect_known(tvb, pinfo, tree)
end

---@param tvb Tvb
---@param _ PInfo
---@param tree TreeItem
function TerrariaDissector:dissect(tvb, _, tree)
	dissect_tcp_pdus(
		tvb,
		tree,
		HEADER_LEN,
		get_pdu_len,
		self.pdu_dissector,
		true
	)
end

return M
