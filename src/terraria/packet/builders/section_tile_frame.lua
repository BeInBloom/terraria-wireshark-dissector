local start_x = ProtoField.int16(
	"terraria.section_tile_frame.start_x",
	"Start X",
	base.DEC
)
local start_y = ProtoField.int16(
	"terraria.section_tile_frame.start_y",
	"Start Y",
	base.DEC
)
local end_x = ProtoField.int16(
	"terraria.section_tile_frame.end_x",
	"End X",
	base.DEC
)
local end_y = ProtoField.int16(
	"terraria.section_tile_frame.end_y",
	"End Y",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(start_x)
	payload:int16_le(start_y)
	payload:int16_le(end_x)
	payload:int16_le(end_y)
end

return {
	id = 11,
	build = build,
	fields = {
		start_x,
		start_y,
		end_x,
		end_y,
	},
}
