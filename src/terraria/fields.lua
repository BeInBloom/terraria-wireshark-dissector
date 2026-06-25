local builders = require("terraria.packet.builders")
local packet_catalog = require("terraria.packet.packet_catalog")

---@class TerrariaFields
---@field length ProtoField
---@field packet_id ProtoField
---@field payload ProtoField
---@field unread_payload ProtoField
---@field missing_builder ProtoExpert
---@field malformed_payload ProtoExpert
---@field unread_payload_expert ProtoExpert
---@field experts ProtoExpert[]
---@field list ProtoField[]

local length = ProtoField.uint16("terraria.length", "Frame Length", base.DEC)
local packet_names = {}

for id, packet in pairs(packet_catalog) do
	packet_names[id] = packet.name
end

local packet_id = ProtoField.uint8(
	"terraria.id",
	"Packet ID",
	base.DEC,
	packet_names
)
local payload = ProtoField.bytes("terraria.payload", "Payload")
local unread_payload = ProtoField.bytes("terraria.payload.unread", "Unread Payload")

local missing_builder = ProtoExpert.new(
	"terraria.expert.missing_builder",
	"Payload decoder is not registered",
	expert.group.PROTOCOL,
	expert.severity.WARN
)
local malformed_payload = ProtoExpert.new(
	"terraria.expert.malformed_payload",
	"Malformed Terraria payload",
	expert.group.MALFORMED,
	expert.severity.ERROR
)
local unread_payload_expert = ProtoExpert.new(
	"terraria.expert.unread_payload",
	"Payload contains unread bytes",
	expert.group.PROTOCOL,
	expert.severity.WARN
)

---@type TerrariaFields
local M = {
	length = length,
	packet_id = packet_id,
	payload = payload,
	unread_payload = unread_payload,
	missing_builder = missing_builder,
	malformed_payload = malformed_payload,
	unread_payload_expert = unread_payload_expert,
	experts = {
		missing_builder,
		malformed_payload,
		unread_payload_expert,
	},
	list = {},
}

M.list = {
	M.length,
	M.packet_id,
	M.payload,
	M.unread_payload,
}

for _, field in ipairs(builders.fields) do
	M.list[#M.list + 1] = field
end

return M
