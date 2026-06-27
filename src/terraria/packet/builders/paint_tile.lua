local x = ProtoField.int16("terraria.paint_tile.x", "X", base.DEC)
local y = ProtoField.int16("terraria.paint_tile.y", "Y", base.DEC)
local color = ProtoField.uint8("terraria.paint_tile.color", "Color", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(x)
	payload:int16_le(y)
	payload:uint8(color)
end

return {
	id = 63,
	build = build,
	fields = {
		x,
		y,
		color,
	},
}
