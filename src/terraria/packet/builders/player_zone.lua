local player_id = ProtoField.uint8("terraria.player_zone.player_id", "Player ID", base.DEC)
local zone_1 = ProtoField.uint8("terraria.player_zone.zone_1", "Zone Flags 1", base.HEX)
local zone_2 = ProtoField.uint8("terraria.player_zone.zone_2", "Zone Flags 2", base.HEX)
local zone_3 = ProtoField.uint8("terraria.player_zone.zone_3", "Zone Flags 3", base.HEX)
local zone_4 = ProtoField.uint8("terraria.player_zone.zone_4", "Zone Flags 4", base.HEX)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:uint8(zone_1)
	payload:uint8(zone_2)
	payload:uint8(zone_3)
	payload:uint8(zone_4)
end

return {
	id = 36,
	build = build,
	fields = {
		player_id,
		zone_1,
		zone_2,
		zone_3,
		zone_4,
	},
}
