local connect_request = require("terraria.packet.builders.connect_request")
local disconnect = require("terraria.packet.builders.disconnect")
local null = require("terraria.packet.builders.null")
local player_active = require("terraria.packet.builders.player_active")
local player_info = require("terraria.packet.builders.player_info")
local player_inventory_slot = require("terraria.packet.builders.player_inventory_slot")
local request_essential_tiles = require("terraria.packet.builders.request_essential_tiles")
local request_world_data = require("terraria.packet.builders.request_world_data")
local section_tile_frame = require("terraria.packet.builders.section_tile_frame")
local send_section = require("terraria.packet.builders.send_section")
local set_user_slot = require("terraria.packet.builders.set_user_slot")
local spawn_player = require("terraria.packet.builders.spawn_player")
local status = require("terraria.packet.builders.status")
local update_player = require("terraria.packet.builders.update_player")
local world_info = require("terraria.packet.builders.world_info")

local definitions = {
	connect_request,
	disconnect,
	set_user_slot,
	player_info,
	player_inventory_slot,
	request_world_data,
	world_info,
	request_essential_tiles,
	status,
	send_section,
	section_tile_frame,
	spawn_player,
	update_player,
	player_active,
	null,
}

---@type table<integer, PayloadBuilder>
local builders = {
	fields = {},
}

for _, definition in ipairs(definitions) do
	builders[definition.id] = definition.build

	for _, field in ipairs(definition.fields) do
		builders.fields[#builders.fields + 1] = field
	end
end

return builders
