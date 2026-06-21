local packet = require("terraria.packet")
local fields = require("terraria.fields")

local terraria = Proto("terraria", "Terraria Protocol")

terraria.fields = fields.list

function terraria.dissector(tvb, _, tree)
	packet.dissect_tcp_stream(terraria, fields, tvb, tree)
end

local tcp_port = assert(DissectorTable.get("tcp.port"), "tcp.port dissector table not found")

tcp_port:add(7777, terraria)
tcp_port:add_for_decode_as(terraria)
