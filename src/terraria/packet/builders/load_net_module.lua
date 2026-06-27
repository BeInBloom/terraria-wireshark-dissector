local module_id = ProtoField.uint16(
	"terraria.load_net_module.module_id",
	"Net Module ID",
	base.DEC
)
local module_data = ProtoField.bytes(
	"terraria.load_net_module.module_data",
	"Net Module Data"
)

---@param payload PayloadReader
local function build(payload)
	payload:uint16_le(module_id)
	payload:remaining_bytes(module_data)
end

return {
	id = 82,
	build = build,
	fields = {
		module_id,
		module_data,
	},
}
