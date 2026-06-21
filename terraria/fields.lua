---@class TerrariaFields
---@field length ProtoField
---@field packet_id ProtoField
---@field payload ProtoField
---@field list ProtoField[]

local length = ProtoField.uint16("terraria.length", "Frame Length", base.DEC)
local packet_id = ProtoField.uint8("terraria.id", "Packet ID", base.DEC)
local payload = ProtoField.bytes("terraria.payload", "Payload")

---@type TerrariaFields
local M = {
	length = length,
	packet_id = packet_id,
	payload = payload,
	list = {
		length,
		packet_id,
		payload,
	},
}

M.list = {
	M.length,
	M.packet_id,
	M.payload,
}

return M
