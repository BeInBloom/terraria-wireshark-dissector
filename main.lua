local terraria = Proto("terraria", "Terraria Protocol")

local packet_names = {
	[1] = "ConnectRequest",
	[3] = "SetUserSlot",
	[4] = "PlayerInfo",
	[5] = "PlayerInventorySlot",
	[6] = "RequestWorldData",
	[7] = "WorldInfo",
	[8] = "RequestEssentialTiles",
	[9] = "Status",
	[10] = "SendSection",
	[11] = "SectionTileFrame",
	[12] = "SpawnPlayer",
	[18] = "Time",
	[49] = "CompleteConnectionAndSpawn",
	[82] = "NetModules",
	[129] = "FinishedConnectingToServer",
}

local f_len = ProtoField.uint16("terraria.length", "Frame Length", base.DEC)
local f_id = ProtoField.uint8("terraria.id", "Packet ID", base.DEC, packet_names)
local f_payload = ProtoField.bytes("terraria.payload", "Payload")

terraria.fields = { f_len, f_id, f_payload }

local function get_pdu_len(tvb, pinfo, offset)
	return tvb(offset, 2):le_uint()
end

local function dissect_pdu(tvb, pinfo, tree)
	local len = tvb(0, 2):le_uint()
	local id = tvb(2, 1):uint()
	local name = packet_names[id] or "Unknown"

	pinfo.cols.protocol = "Terraria"
	pinfo.cols.info = string.format("%s id=%d len=%d", name, id, len)

	local subtree = tree:add(terraria, tvb(), string.format("Terraria %s", name))
	subtree:add_le(f_len, tvb(0, 2))
	subtree:add(f_id, tvb(2, 1))

	if len > 3 then
		subtree:add(f_payload, tvb(3, len - 3))
	end

	return tvb:len()
end

function terraria.dissector(tvb, pinfo, tree)
	dissect_tcp_pdus(tvb, tree, 3, get_pdu_len, dissect_pdu, true)
end

DissectorTable.get("tcp.port"):add(7777, terraria)
DissectorTable.get("tcp.port"):add(7778, terraria)
