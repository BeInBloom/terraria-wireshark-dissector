local unique_id = ProtoField.int32("terraria.remove_revenge_marker.unique_id", "Unique ID", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int32_le(unique_id)
end

return {
	id = 127,
	build = build,
	fields = {
		unique_id,
	},
}
