local position = ProtoField.bytes("terraria.request_essential_tiles.position", "Tile Position")
local x = ProtoField.int32("terraria.request_essential_tiles.x", "X", base.DEC)
local y = ProtoField.int32("terraria.request_essential_tiles.y", "Y", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int32_pair(position, x, y)
end

return {
	id = 8,
	build = build,
	fields = {
		position,
		x,
		y,
	},
}
