local packed_vector = ProtoField.uint32(
	"terraria.poof_of_smoke.packed_vector",
	"Packed Vector",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint32_le(packed_vector)
end

return {
	id = 106,
	build = build,
	fields = {
		packed_vector,
	},
}
