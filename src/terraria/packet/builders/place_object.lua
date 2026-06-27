local x = ProtoField.int16("terraria.place_object.x", "X", base.DEC)
local y = ProtoField.int16("terraria.place_object.y", "Y", base.DEC)
local object_type = ProtoField.int16("terraria.place_object.type", "Type", base.DEC)
local style = ProtoField.int16("terraria.place_object.style", "Style", base.DEC)
local alternate = ProtoField.uint8("terraria.place_object.alternate", "Alternate", base.DEC)
local random = ProtoField.int8("terraria.place_object.random", "Random", base.DEC)
local direction = ProtoField.bool("terraria.place_object.direction", "Direction")

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(x)
	payload:int16_le(y)
	payload:int16_le(object_type)
	payload:int16_le(style)
	payload:uint8(alternate)
	payload:sbyte(random)
	payload:bool(direction)
end

return {
	id = 79,
	build = build,
	fields = {
		x,
		y,
		object_type,
		style,
		alternate,
		random,
		direction,
	},
}
