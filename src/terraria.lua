local Dissector = require("terraria.dissector")
local fields = require("terraria.fields")

local terraria = Proto("terraria", "Terraria Protocol")

terraria.fields = fields.list
terraria.experts = fields.experts

local dissector = Dissector.new(terraria, fields)

function terraria.dissector(tvb, pinfi, tree)
	dissector:dissect(tvb, pinfi, tree)
end

local tcp_port = assert(DissectorTable.get("tcp.port"), "tcp.port dissector table not found")

tcp_port:add(7777, terraria)
tcp_port:add_for_decode_as(terraria)
