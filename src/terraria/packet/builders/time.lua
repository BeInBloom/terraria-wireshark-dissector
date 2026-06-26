local day_time = ProtoField.bool("terraria.time.day_time", "Day Time")
local time_value = ProtoField.int32("terraria.time.value", "Time Value", base.DEC)
local sun_mod_y = ProtoField.int16("terraria.time.sun_mod_y", "Sun Mod Y", base.DEC)
local moon_mod_y = ProtoField.int16("terraria.time.moon_mod_y", "Moon Mod Y", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:bool(day_time)
	payload:int32_le(time_value)
	payload:int16_le(sun_mod_y)
	payload:int16_le(moon_mod_y)
end

return {
	id = 18,
	build = build,
	fields = {
		day_time,
		time_value,
		sun_mod_y,
		moon_mod_y,
	},
}
