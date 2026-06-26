local start_position = ProtoField.bytes("terraria.section_tile_frame.start", "Start")
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
local end_position = ProtoField.bytes("terraria.section_tile_frame.end", "End")
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
	payload:int16_pair(start_position, start_x, start_y)
	payload:int16_pair(end_position, end_x, end_y)
end

return {
	id = 11,
	build = build,
	fields = {
		start_position,
		start_x,
		start_y,
		end_position,
		end_x,
		end_y,
	},
}
