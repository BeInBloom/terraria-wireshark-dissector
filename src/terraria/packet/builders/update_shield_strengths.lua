local solar = ProtoField.uint16(
	"terraria.update_shield_strengths.solar",
	"Solar Tower Shield Strength",
	base.DEC
)
local vortex = ProtoField.uint16(
	"terraria.update_shield_strengths.vortex",
	"Vortex Tower Shield Strength",
	base.DEC
)
local nebula = ProtoField.uint16(
	"terraria.update_shield_strengths.nebula",
	"Nebula Tower Shield Strength",
	base.DEC
)
local stardust = ProtoField.uint16(
	"terraria.update_shield_strengths.stardust",
	"Stardust Tower Shield Strength",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint16_le(solar)
	payload:uint16_le(vortex)
	payload:uint16_le(nebula)
	payload:uint16_le(stardust)
end

return {
	id = 101,
	build = build,
	fields = {
		solar,
		vortex,
		nebula,
		stardust,
	},
}
