local potion_type = ProtoField.uint8(
	"terraria.teleportation_potion.type",
	"Type",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(potion_type)
end

return {
	id = 73,
	build = build,
	fields = {
		potion_type,
	},
}
