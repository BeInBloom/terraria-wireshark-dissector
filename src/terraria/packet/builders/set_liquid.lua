local x = ProtoField.int16("terraria.set_liquid.x", "X", base.DEC)
local y = ProtoField.int16("terraria.set_liquid.y", "Y", base.DEC)
local liquid = ProtoField.uint8("terraria.set_liquid.liquid", "Liquid", base.DEC)
local liquid_type = ProtoField.uint8(
	"terraria.set_liquid.liquid_type",
	"Liquid Type",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(x)
	payload:int16_le(y)
	payload:uint8(liquid)
	payload:uint8(liquid_type)
end

return {
	id = 48,
	build = build,
	fields = {
		x,
		y,
		liquid,
		liquid_type,
	},
}
