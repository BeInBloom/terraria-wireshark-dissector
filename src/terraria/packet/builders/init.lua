local connect_request = require("terraria.packet.builders.connect_request")
local disconnect = require("terraria.packet.builders.disconnect")
local destroy_projectile = require("terraria.packet.builders.destroy_projectile")
local door_toggle = require("terraria.packet.builders.door_toggle")
local modify_tile = require("terraria.packet.builders.modify_tile")
local npc_strike = require("terraria.packet.builders.npc_strike")
local npc_update = require("terraria.packet.builders.npc_update")
local null = require("terraria.packet.builders.null")
local null_25 = require("terraria.packet.builders.null_25")
local null_26 = require("terraria.packet.builders.null_26")
local player_active = require("terraria.packet.builders.player_active")
local player_hp = require("terraria.packet.builders.player_hp")
local player_info = require("terraria.packet.builders.player_info")
local player_inventory_slot = require("terraria.packet.builders.player_inventory_slot")
local projectile_update = require("terraria.packet.builders.projectile_update")
local request_essential_tiles = require("terraria.packet.builders.request_essential_tiles")
local request_world_data = require("terraria.packet.builders.request_world_data")
local section_tile_frame = require("terraria.packet.builders.section_tile_frame")
local send_section = require("terraria.packet.builders.send_section")
local send_tile_square = require("terraria.packet.builders.send_tile_square")
local set_user_slot = require("terraria.packet.builders.set_user_slot")
local spawn_player = require("terraria.packet.builders.spawn_player")
local status = require("terraria.packet.builders.status")
local strike_npc_with_held_item = require("terraria.packet.builders.strike_npc_with_held_item")
local time = require("terraria.packet.builders.time")
local toggle_pvp = require("terraria.packet.builders.toggle_pvp")
local update_item_drop = require("terraria.packet.builders.update_item_drop")
local update_item_owner = require("terraria.packet.builders.update_item_owner")
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
	player_hp,
	modify_tile,
	time,
	door_toggle,
	send_tile_square,
	update_item_drop,
	update_item_owner,
	npc_update,
	strike_npc_with_held_item,
	null_25,
	null_26,
	projectile_update,
	npc_strike,
	destroy_projectile,
	toggle_pvp,
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
