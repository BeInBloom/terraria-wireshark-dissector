local fields = {}

---@param factory fun(name: string, label: string, display: any): ProtoField
---@param name string
---@param label string
---@param display any
---@return ProtoField
local function define(factory, name, label, display)
	local field = factory("terraria.world_info." .. name, label, display)
	fields[#fields + 1] = field
	return field
end

local time_state = define(ProtoField.bytes, "time_state", "Time State")
local geometry = define(ProtoField.bytes, "geometry", "Geometry")
local world_size = define(ProtoField.bytes, "world_size", "World Size")
local spawn_position = define(ProtoField.bytes, "spawn_position", "Spawn Position")
local world_layers = define(ProtoField.bytes, "world_layers", "World Layers")
local identity = define(ProtoField.bytes, "identity", "Identity")
local backgrounds = define(ProtoField.bytes, "backgrounds", "Backgrounds")
local biome_backgrounds = define(ProtoField.bytes, "biome_backgrounds", "Biome Backgrounds")
local background_styles = define(ProtoField.bytes, "background_styles", "Background Styles")
local tree_layout = define(ProtoField.bytes, "tree_layout", "Tree Layout")
local tree_positions = define(ProtoField.bytes, "tree_positions", "Tree Positions")
local tree_styles = define(ProtoField.bytes, "tree_styles", "Tree Styles")
local cave_backgrounds = define(ProtoField.bytes, "cave_backgrounds", "Cave Backgrounds")
local cave_styles = define(ProtoField.bytes, "cave_styles", "Cave Styles")
local tree_tops = define(ProtoField.bytes, "tree_tops", "Tree Tops")
local events = define(ProtoField.bytes, "events", "Events")
local event_flags = define(ProtoField.bytes, "event_flags", "Event Flags")
local progression = define(ProtoField.bytes, "progression", "Progression")
local ore_tiers = define(ProtoField.bytes, "ore_tiers", "Ore Tiers")

local time = define(ProtoField.int32, "time", "Time", base.DEC)
local day_moon_info = define(ProtoField.uint8, "day_moon_info", "Day and Moon Info", base.HEX)
local moon_phase = define(ProtoField.uint8, "moon_phase", "Moon Phase", base.DEC)
local max_tiles_x = define(ProtoField.int16, "max_tiles_x", "Max Tiles X", base.DEC)
local max_tiles_y = define(ProtoField.int16, "max_tiles_y", "Max Tiles Y", base.DEC)
local spawn_x = define(ProtoField.int16, "spawn_x", "Spawn X", base.DEC)
local spawn_y = define(ProtoField.int16, "spawn_y", "Spawn Y", base.DEC)
local world_surface = define(ProtoField.int16, "world_surface", "World Surface", base.DEC)
local rock_layer = define(ProtoField.int16, "rock_layer", "Rock Layer", base.DEC)
local world_id = define(ProtoField.int32, "world_id", "World ID", base.DEC)
local world_name = define(ProtoField.string, "world_name", "World Name")
local game_mode = define(ProtoField.uint8, "game_mode", "Game Mode", base.DEC)
local unique_id = define(ProtoField.bytes, "unique_id", "World Unique ID")
local generator_version = define(
	ProtoField.uint64,
	"generator_version",
	"World Generator Version",
	base.DEC
)
local moon_type = define(ProtoField.uint8, "moon_type", "Moon Type", base.DEC)

local tree_background = define(ProtoField.uint8, "tree_background", "Tree Background", base.DEC)
local corruption_background = define(
	ProtoField.uint8,
	"corruption_background",
	"Corruption Background",
	base.DEC
)
local jungle_background = define(ProtoField.uint8, "jungle_background", "Jungle Background", base.DEC)
local snow_background = define(ProtoField.uint8, "snow_background", "Snow Background", base.DEC)
local hallow_background = define(ProtoField.uint8, "hallow_background", "Hallow Background", base.DEC)
local crimson_background = define(
	ProtoField.uint8,
	"crimson_background",
	"Crimson Background",
	base.DEC
)
local desert_background = define(ProtoField.uint8, "desert_background", "Desert Background", base.DEC)
local ocean_background = define(ProtoField.uint8, "ocean_background", "Ocean Background", base.DEC)
local background_1 = define(ProtoField.uint8, "background_1", "Background 1", base.DEC)
local background_2 = define(ProtoField.uint8, "background_2", "Background 2", base.DEC)
local background_3 = define(ProtoField.uint8, "background_3", "Background 3", base.DEC)
local background_4 = define(ProtoField.uint8, "background_4", "Background 4", base.DEC)
local background_5 = define(ProtoField.uint8, "background_5", "Background 5", base.DEC)
local ice_back_style = define(ProtoField.uint8, "ice_back_style", "Ice Back Style", base.DEC)
local jungle_back_style = define(ProtoField.uint8, "jungle_back_style", "Jungle Back Style", base.DEC)
local hell_back_style = define(ProtoField.uint8, "hell_back_style", "Hell Back Style", base.DEC)
local wind_speed = define(ProtoField.float, "wind_speed", "Wind Speed")
local cloud_number = define(ProtoField.uint8, "cloud_number", "Cloud Number", base.DEC)

local tree_1 = define(ProtoField.int32, "tree_1", "Tree 1", base.DEC)
local tree_2 = define(ProtoField.int32, "tree_2", "Tree 2", base.DEC)
local tree_3 = define(ProtoField.int32, "tree_3", "Tree 3", base.DEC)
local tree_style_1 = define(ProtoField.uint8, "tree_style_1", "Tree Style 1", base.DEC)
local tree_style_2 = define(ProtoField.uint8, "tree_style_2", "Tree Style 2", base.DEC)
local tree_style_3 = define(ProtoField.uint8, "tree_style_3", "Tree Style 3", base.DEC)
local tree_style_4 = define(ProtoField.uint8, "tree_style_4", "Tree Style 4", base.DEC)
local cave_back_1 = define(ProtoField.int32, "cave_back_1", "Cave Back 1", base.DEC)
local cave_back_2 = define(ProtoField.int32, "cave_back_2", "Cave Back 2", base.DEC)
local cave_back_3 = define(ProtoField.int32, "cave_back_3", "Cave Back 3", base.DEC)
local cave_style_1 = define(ProtoField.uint8, "cave_style_1", "Cave Back Style 1", base.DEC)
local cave_style_2 = define(ProtoField.uint8, "cave_style_2", "Cave Back Style 2", base.DEC)
local cave_style_3 = define(ProtoField.uint8, "cave_style_3", "Cave Back Style 3", base.DEC)
local cave_style_4 = define(ProtoField.uint8, "cave_style_4", "Cave Back Style 4", base.DEC)

local forest_top_1 = define(ProtoField.int32, "forest_top_1", "Forest 1 Tree Top Style", base.DEC)
local forest_top_2 = define(ProtoField.int32, "forest_top_2", "Forest 2 Tree Top Style", base.DEC)
local forest_top_3 = define(ProtoField.int32, "forest_top_3", "Forest 3 Tree Top Style", base.DEC)
local forest_top_4 = define(ProtoField.int32, "forest_top_4", "Forest 4 Tree Top Style", base.DEC)
local corruption_top = define(ProtoField.int32, "corruption_top", "Corruption Tree Top Style", base.DEC)
local jungle_top = define(ProtoField.int32, "jungle_top", "Jungle Tree Top Style", base.DEC)
local snow_top = define(ProtoField.int32, "snow_top", "Snow Tree Top Style", base.DEC)
local hallow_top = define(ProtoField.int32, "hallow_top", "Hallow Tree Top Style", base.DEC)
local crimson_top = define(ProtoField.int32, "crimson_top", "Crimson Tree Top Style", base.DEC)
local desert_top = define(ProtoField.int32, "desert_top", "Desert Tree Top Style", base.DEC)
local ocean_top = define(ProtoField.int32, "ocean_top", "Ocean Tree Top Style", base.DEC)
local mushroom_top = define(ProtoField.int32, "mushroom_top", "Mushroom Tree Top Style", base.DEC)
local underworld_top = define(ProtoField.int32, "underworld_top", "Underworld Tree Top Style", base.DEC)

local rain = define(ProtoField.float, "rain", "Rain")
local event_info = define(ProtoField.uint8, "event_info", "Event Info", base.HEX)
local event_info_2 = define(ProtoField.uint8, "event_info_2", "Event Info 2", base.HEX)
local event_info_3 = define(ProtoField.uint8, "event_info_3", "Event Info 3", base.HEX)
local event_info_4 = define(ProtoField.uint8, "event_info_4", "Event Info 4", base.HEX)
local event_info_5 = define(ProtoField.uint8, "event_info_5", "Event Info 5", base.HEX)
local event_info_6 = define(ProtoField.uint8, "event_info_6", "Event Info 6", base.HEX)
local event_info_7 = define(ProtoField.uint8, "event_info_7", "Event Info 7", base.HEX)

local copper_ore = define(ProtoField.int16, "copper_ore", "Copper Ore Tier", base.DEC)
local iron_ore = define(ProtoField.int16, "iron_ore", "Iron Ore Tier", base.DEC)
local silver_ore = define(ProtoField.int16, "silver_ore", "Silver Ore Tier", base.DEC)
local gold_ore = define(ProtoField.int16, "gold_ore", "Gold Ore Tier", base.DEC)
local cobalt_ore = define(ProtoField.int16, "cobalt_ore", "Cobalt Ore Tier", base.DEC)
local mythril_ore = define(ProtoField.int16, "mythril_ore", "Mythril Ore Tier", base.DEC)
local adamantite_ore = define(ProtoField.int16, "adamantite_ore", "Adamantite Ore Tier", base.DEC)
local invasion_type = define(ProtoField.int8, "invasion_type", "Invasion Type", base.DEC)
local lobby_id = define(ProtoField.uint64, "lobby_id", "Lobby ID", base.DEC)
local sandstorm_severity = define(ProtoField.float, "sandstorm_severity", "Sandstorm Severity")

---@param payload PayloadReader
local function build_time_state(payload)
	payload:group(time_state, function(payload)
		payload:int32_le(time)
		payload:uint8(day_moon_info)
		payload:uint8(moon_phase)
	end)
end

---@param payload PayloadReader
local function build_geometry(payload)
	payload:group(geometry, function(payload)
		payload:group(world_size, function(payload)
			payload:int16_le(max_tiles_x)
			payload:int16_le(max_tiles_y)
		end)
		payload:group(spawn_position, function(payload)
			payload:int16_le(spawn_x)
			payload:int16_le(spawn_y)
		end)
		payload:group(world_layers, function(payload)
			payload:int16_le(world_surface)
			payload:int16_le(rock_layer)
		end)
	end)
end

---@param payload PayloadReader
local function build_identity(payload)
	payload:group(identity, function(payload)
		payload:int32_le(world_id)
		payload:string(world_name)
		payload:uint8(game_mode)
		payload:bytes(unique_id, 16)
		payload:uint64_le(generator_version)
		payload:uint8(moon_type)
	end)
end

---@param payload PayloadReader
local function build_biome_backgrounds(payload)
	payload:group(biome_backgrounds, function(payload)
		payload:uint8(tree_background)
		payload:uint8(corruption_background)
		payload:uint8(jungle_background)
		payload:uint8(snow_background)
		payload:uint8(hallow_background)
		payload:uint8(crimson_background)
		payload:uint8(desert_background)
		payload:uint8(ocean_background)
	end)
end

---@param payload PayloadReader
local function build_background_styles(payload)
	payload:group(background_styles, function(payload)
		payload:uint8(background_1)
		payload:uint8(background_2)
		payload:uint8(background_3)
		payload:uint8(background_4)
		payload:uint8(background_5)
		payload:uint8(ice_back_style)
		payload:uint8(jungle_back_style)
		payload:uint8(hell_back_style)
	end)
end

---@param payload PayloadReader
local function build_backgrounds(payload)
	payload:group(backgrounds, function(payload)
		build_biome_backgrounds(payload)
		build_background_styles(payload)
		payload:single_le(wind_speed)
		payload:uint8(cloud_number)
	end)
end

---@param payload PayloadReader
local function build_tree_positions(payload)
	payload:group(tree_positions, function(payload)
		payload:int32_le(tree_1)
		payload:int32_le(tree_2)
		payload:int32_le(tree_3)
	end)
end

---@param payload PayloadReader
local function build_tree_styles(payload)
	payload:group(tree_styles, function(payload)
		payload:uint8(tree_style_1)
		payload:uint8(tree_style_2)
		payload:uint8(tree_style_3)
		payload:uint8(tree_style_4)
	end)
end

---@param payload PayloadReader
local function build_cave_backgrounds(payload)
	payload:group(cave_backgrounds, function(payload)
		payload:int32_le(cave_back_1)
		payload:int32_le(cave_back_2)
		payload:int32_le(cave_back_3)
	end)
end

---@param payload PayloadReader
local function build_cave_styles(payload)
	payload:group(cave_styles, function(payload)
		payload:uint8(cave_style_1)
		payload:uint8(cave_style_2)
		payload:uint8(cave_style_3)
		payload:uint8(cave_style_4)
	end)
end

---@param payload PayloadReader
local function build_tree_layout(payload)
	payload:group(tree_layout, function(payload)
		build_tree_positions(payload)
		build_tree_styles(payload)
		build_cave_backgrounds(payload)
		build_cave_styles(payload)
	end)
end

---@param payload PayloadReader
local function build_tree_tops(payload)
	payload:group(tree_tops, function(payload)
		payload:int32_le(forest_top_1)
		payload:int32_le(forest_top_2)
		payload:int32_le(forest_top_3)
		payload:int32_le(forest_top_4)
		payload:int32_le(corruption_top)
		payload:int32_le(jungle_top)
		payload:int32_le(snow_top)
		payload:int32_le(hallow_top)
		payload:int32_le(crimson_top)
		payload:int32_le(desert_top)
		payload:int32_le(ocean_top)
		payload:int32_le(mushroom_top)
		payload:int32_le(underworld_top)
	end)
end

---@param payload PayloadReader
local function build_event_flags(payload)
	payload:group(event_flags, function(payload)
		local event_fields = {
			event_info,
			event_info_2,
			event_info_3,
			event_info_4,
			event_info_5,
			event_info_6,
			event_info_7,
		}

		for index = 1, #event_fields do
			if payload.reader:remaining() == 0 then
				return
			end

			payload:uint8(event_fields[index])
		end
	end)
end

---@param payload PayloadReader
local function build_events(payload)
	payload:group(events, function(payload)
		payload:single_le(rain)
		build_event_flags(payload)
	end)
end

---@param payload PayloadReader
local function build_ore_tiers(payload)
	payload:group(ore_tiers, function(payload)
		local ore_fields = {
			copper_ore,
			iron_ore,
			silver_ore,
			gold_ore,
			cobalt_ore,
			mythril_ore,
			adamantite_ore,
		}

		for index = 1, #ore_fields do
			if payload.reader:remaining() < 2 then
				return
			end

			payload:int16_le(ore_fields[index])
		end
	end)
end

---@param payload PayloadReader
local function build_progression(payload)
	payload:group(progression, function(payload)
		build_ore_tiers(payload)

		if payload.reader:remaining() >= 1 then
			payload:sbyte(invasion_type)
		end

		if payload.reader:remaining() >= 8 then
			payload:uint64_le(lobby_id)
		end

		if payload.reader:remaining() >= 4 then
			payload:single_le(sandstorm_severity)
		end
	end)
end

---@param payload PayloadReader
local function build(payload)
	build_time_state(payload)
	build_geometry(payload)
	build_identity(payload)
	build_backgrounds(payload)
	build_tree_layout(payload)
	build_tree_tops(payload)
	build_events(payload)

	if payload.reader:remaining() > 0 then
		build_progression(payload)
	end
end

return {
	id = 7,
	build = build,
	fields = fields,
}
