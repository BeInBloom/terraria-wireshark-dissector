local connect_request = require("terraria.packet.builders.connect_request")
local heal_effect = require("terraria.packet.builders.heal_effect")
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
local player_zone = require("terraria.packet.builders.player_zone")
local player_item_animation = require("terraria.packet.builders.player_item_animation")
local player_mana = require("terraria.packet.builders.player_mana")
local projectile_update = require("terraria.packet.builders.projectile_update")
local place_chest = require("terraria.packet.builders.place_chest")
local remove_item_owner = require("terraria.packet.builders.remove_item_owner")
local request_essential_tiles = require("terraria.packet.builders.request_essential_tiles")
local request_password = require("terraria.packet.builders.request_password")
local request_world_data = require("terraria.packet.builders.request_world_data")
local mana_effect = require("terraria.packet.builders.mana_effect")
local special_npc_effect = require("terraria.packet.builders.special_npc_effect")
local unlock = require("terraria.packet.builders.unlock")
local add_npc_buff = require("terraria.packet.builders.add_npc_buff")
local update_npc_buff = require("terraria.packet.builders.update_npc_buff")
local add_player_buff = require("terraria.packet.builders.add_player_buff")
local update_npc_name = require("terraria.packet.builders.update_npc_name")
local update_good_evil = require("terraria.packet.builders.update_good_evil")
local play_music_item = require("terraria.packet.builders.play_music_item")
local hit_switch = require("terraria.packet.builders.hit_switch")
local npc_home_update = require("terraria.packet.builders.npc_home_update")
local section_tile_frame = require("terraria.packet.builders.section_tile_frame")
local send_section = require("terraria.packet.builders.send_section")
local send_tile_square = require("terraria.packet.builders.send_tile_square")
local send_password = require("terraria.packet.builders.send_password")
local set_user_slot = require("terraria.packet.builders.set_user_slot")
local set_active_npc = require("terraria.packet.builders.set_active_npc")
local player_team = require("terraria.packet.builders.player_team")
local request_sign = require("terraria.packet.builders.request_sign")
local update_sign = require("terraria.packet.builders.update_sign")
local set_liquid = require("terraria.packet.builders.set_liquid")
local complete_connection_and_spawn = require("terraria.packet.builders.complete_connection_and_spawn")
local update_player_buff = require("terraria.packet.builders.update_player_buff")
local null_44 = require("terraria.packet.builders.null_44")
local spawn_player = require("terraria.packet.builders.spawn_player")
local status = require("terraria.packet.builders.status")
local strike_npc_with_held_item = require("terraria.packet.builders.strike_npc_with_held_item")
local sync_active_chest = require("terraria.packet.builders.sync_active_chest")
local update_chest_item = require("terraria.packet.builders.update_chest_item")
local time = require("terraria.packet.builders.time")
local toggle_pvp = require("terraria.packet.builders.toggle_pvp")
local update_item_drop = require("terraria.packet.builders.update_item_drop")
local update_item_owner = require("terraria.packet.builders.update_item_owner")
local update_player = require("terraria.packet.builders.update_player")
local open_chest = require("terraria.packet.builders.open_chest")
local world_info = require("terraria.packet.builders.world_info")
local spawn_boss_invasion = require("terraria.packet.builders.spawn_boss_invasion")
local player_dodge = require("terraria.packet.builders.player_dodge")
local paint_tile = require("terraria.packet.builders.paint_tile")
local paint_wall = require("terraria.packet.builders.paint_wall")
local player_npc_teleport = require("terraria.packet.builders.player_npc_teleport")
local heal_other_player = require("terraria.packet.builders.heal_other_player")
local placeholder = require("terraria.packet.builders.placeholder")
local client_uuid = require("terraria.packet.builders.client_uuid")
local get_chest_name = require("terraria.packet.builders.get_chest_name")
local catch_npc = require("terraria.packet.builders.catch_npc")
local release_npc = require("terraria.packet.builders.release_npc")
local travelling_merchant_inventory = require("terraria.packet.builders.travelling_merchant_inventory")
local teleportation_potion = require("terraria.packet.builders.teleportation_potion")
local angler_quest = require("terraria.packet.builders.angler_quest")
local complete_angler_quest_today = require("terraria.packet.builders.complete_angler_quest_today")
local number_of_angler_quests_completed = require("terraria.packet.builders.number_of_angler_quests_completed")
local create_temporary_animation = require("terraria.packet.builders.create_temporary_animation")
local report_invasion_progress = require("terraria.packet.builders.report_invasion_progress")
local place_object = require("terraria.packet.builders.place_object")
local sync_player_chest_index = require("terraria.packet.builders.sync_player_chest_index")
local create_combat_text = require("terraria.packet.builders.create_combat_text")
local load_net_module = require("terraria.packet.builders.load_net_module")
local set_npc_kill_count = require("terraria.packet.builders.set_npc_kill_count")
local set_player_stealth = require("terraria.packet.builders.set_player_stealth")
local force_item_into_nearest_chest = require("terraria.packet.builders.force_item_into_nearest_chest")
local update_tile_entity = require("terraria.packet.builders.update_tile_entity")
local place_tile_entity = require("terraria.packet.builders.place_tile_entity")
local tweak_item = require("terraria.packet.builders.tweak_item")
local place_item_frame = require("terraria.packet.builders.place_item_frame")
local update_item_drop_2 = require("terraria.packet.builders.update_item_drop_2")
local sync_emote_bubble = require("terraria.packet.builders.sync_emote_bubble")
local sync_extra_value = require("terraria.packet.builders.sync_extra_value")
local social_handshake = require("terraria.packet.builders.social_handshake")
local deprecated = require("terraria.packet.builders.deprecated")
local kill_portal = require("terraria.packet.builders.kill_portal")
local player_teleport_portal = require("terraria.packet.builders.player_teleport_portal")
local notify_player_npc_killed = require("terraria.packet.builders.notify_player_npc_killed")
local notify_player_of_event = require("terraria.packet.builders.notify_player_of_event")
local update_minion_target = require("terraria.packet.builders.update_minion_target")
local npc_teleport_portal = require("terraria.packet.builders.npc_teleport_portal")
local update_shield_strengths = require("terraria.packet.builders.update_shield_strengths")
local nebula_level_up = require("terraria.packet.builders.nebula_level_up")
local moon_lord_countdown = require("terraria.packet.builders.moon_lord_countdown")
local npc_shop_item = require("terraria.packet.builders.npc_shop_item")
local gem_lock_toggle = require("terraria.packet.builders.gem_lock_toggle")
local poof_of_smoke = require("terraria.packet.builders.poof_of_smoke")
local smart_text_message = require("terraria.packet.builders.smart_text_message")
local wired_cannon_shot = require("terraria.packet.builders.wired_cannon_shot")
local mass_wire_operation = require("terraria.packet.builders.mass_wire_operation")
local mass_wire_operation_consume = require("terraria.packet.builders.mass_wire_operation_consume")
local toggle_birthday_party = require("terraria.packet.builders.toggle_birthday_party")
local growfx = require("terraria.packet.builders.growfx")
local crystal_invasion_start = require("terraria.packet.builders.crystal_invasion_start")
local crystal_invasion_wipe_all = require("terraria.packet.builders.crystal_invasion_wipe_all")
local minion_attack_target_update = require("terraria.packet.builders.minion_attack_target_update")
local crystal_invasion_send_wait_time = require("terraria.packet.builders.crystal_invasion_send_wait_time")
local player_hurt_v2 = require("terraria.packet.builders.player_hurt_v2")
local player_death_v2 = require("terraria.packet.builders.player_death_v2")
local combat_text_string = require("terraria.packet.builders.combat_text_string")
local emoji = require("terraria.packet.builders.emoji")
local te_display_doll_item_sync = require("terraria.packet.builders.te_display_doll_item_sync")
local request_tile_entity_interaction = require("terraria.packet.builders.request_tile_entity_interaction")
local weapons_rack_try_placing = require("terraria.packet.builders.weapons_rack_try_placing")
local te_hat_rack_item_sync = require("terraria.packet.builders.te_hat_rack_item_sync")
local sync_tile_picking = require("terraria.packet.builders.sync_tile_picking")
local sync_revenge_marker = require("terraria.packet.builders.sync_revenge_marker")
local remove_revenge_marker = require("terraria.packet.builders.remove_revenge_marker")
local land_golf_ball_in_cup = require("terraria.packet.builders.land_golf_ball_in_cup")
local finished_connecting_to_server = require("terraria.packet.builders.finished_connecting_to_server")
local fish_out_npc = require("terraria.packet.builders.fish_out_npc")
local tamper_with_npc = require("terraria.packet.builders.tamper_with_npc")
local play_legacy_sound = require("terraria.packet.builders.play_legacy_sound")
local food_platter_try_placing = require("terraria.packet.builders.food_platter_try_placing")
local update_player_luck_factors = require("terraria.packet.builders.update_player_luck_factors")
local dead_player = require("terraria.packet.builders.dead_player")
local sync_cavern_monster_type = require("terraria.packet.builders.sync_cavern_monster_type")
local request_npc_buff_removal = require("terraria.packet.builders.request_npc_buff_removal")
local client_finished_inventory_changes_on_this_tick = require("terraria.packet.builders.client_finished_inventory_changes_on_this_tick")
local set_counts_as_host_for_gameplay = require("terraria.packet.builders.set_counts_as_host_for_gameplay")
local set_misc_event_values = require("terraria.packet.builders.set_misc_event_values")

local definitions = {
	connect_request,
	disconnect,
	set_user_slot,
	player_info,
	player_inventory_slot,
	open_chest,
	update_chest_item,
	sync_active_chest,
	place_chest,
	heal_effect,
	player_zone,
	request_password,
	send_password,
	remove_item_owner,
	set_active_npc,
	player_item_animation,
	player_mana,
	mana_effect,
	null_44,
	player_team,
	request_sign,
	update_sign,
	set_liquid,
	complete_connection_and_spawn,
	update_player_buff,
	special_npc_effect,
	unlock,
	add_npc_buff,
	update_npc_buff,
	add_player_buff,
	update_npc_name,
	update_good_evil,
	play_music_item,
	hit_switch,
	npc_home_update,
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
	spawn_boss_invasion,
	player_dodge,
	paint_tile,
	paint_wall,
	player_npc_teleport,
	heal_other_player,
	placeholder,
	client_uuid,
	get_chest_name,
	catch_npc,
	release_npc,
	travelling_merchant_inventory,
	teleportation_potion,
	angler_quest,
	complete_angler_quest_today,
	number_of_angler_quests_completed,
	create_temporary_animation,
	report_invasion_progress,
	place_object,
	sync_player_chest_index,
	create_combat_text,
	load_net_module,
	set_npc_kill_count,
	set_player_stealth,
	force_item_into_nearest_chest,
	update_tile_entity,
	place_tile_entity,
	tweak_item,
	place_item_frame,
	update_item_drop_2,
	sync_emote_bubble,
	sync_extra_value,
	social_handshake,
	deprecated,
	kill_portal,
	player_teleport_portal,
	notify_player_npc_killed,
	notify_player_of_event,
	update_minion_target,
	npc_teleport_portal,
	update_shield_strengths,
	nebula_level_up,
	moon_lord_countdown,
	npc_shop_item,
	gem_lock_toggle,
	poof_of_smoke,
	smart_text_message,
	wired_cannon_shot,
	mass_wire_operation,
	mass_wire_operation_consume,
	toggle_birthday_party,
	growfx,
	crystal_invasion_start,
	crystal_invasion_wipe_all,
	minion_attack_target_update,
	crystal_invasion_send_wait_time,
	player_hurt_v2,
	player_death_v2,
	combat_text_string,
	emoji,
	te_display_doll_item_sync,
	request_tile_entity_interaction,
	weapons_rack_try_placing,
	te_hat_rack_item_sync,
	sync_tile_picking,
	sync_revenge_marker,
	remove_revenge_marker,
	land_golf_ball_in_cup,
	finished_connecting_to_server,
	fish_out_npc,
	tamper_with_npc,
	play_legacy_sound,
	food_platter_try_placing,
	update_player_luck_factors,
	dead_player,
	sync_cavern_monster_type,
	request_npc_buff_removal,
	client_finished_inventory_changes_on_this_tick,
	set_counts_as_host_for_gameplay,
	set_misc_event_values,
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
