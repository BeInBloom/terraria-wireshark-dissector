local Packet = {}
Packet.__index = Packet

---@param length integer
---@param packet_type PacketType
---@param payload Payload
---@return Packet
function Packet.new(length, packet_type, payload)
	return setmetatable({
		length = length,
		type = packet_type,
		payload = payload,
	}, Packet)
end

---@return boolean
function Packet:is_valid()
	return self.type:is_valid() and self.payload:is_valid()
end

return Packet
