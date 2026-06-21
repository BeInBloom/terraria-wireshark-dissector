local M = {}

local HEADER_LEN = 3

---@param tvb Tvb
---@param _ PInfo
---@param offset integer
---@return integer
local function get_pdu_len(tvb, _, offset)
	return tvb(offset, 2):le_uint()
end

---@param proto Proto
---@param fields TerrariaFields
---@return fun(tvb: Tvb, pinfo: PInfo, tree: TreeItem): integer
local function make_pdu_dissector(proto, fields)
	return function(tvb, pinfo, tree)
		local len = tvb(0, 2):le_uint()
		local id = tvb(2, 1):uint()

		pinfo.cols.protocol = "Terraria"
		pinfo.cols.info = string.format("id=%d len=%d", id, len)

		local subtree = tree:add(proto, tvb(), "Terraria Packet")

		subtree:add_le(fields.length, tvb(0, 2))
		subtree:add(fields.packet_id, tvb(2, 1))

		local payload_len = len - HEADER_LEN

		if payload_len > 0 then
			subtree:add(fields.payload, tvb(HEADER_LEN, payload_len))
		end

		return len
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
