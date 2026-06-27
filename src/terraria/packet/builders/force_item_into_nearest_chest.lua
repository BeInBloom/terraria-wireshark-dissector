local inventory_slot = ProtoField.uint8(
	"terraria.force_item_into_nearest_chest.inventory_slot",
	"Inventory Slot",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(inventory_slot)
end

return {
	id = 85,
	build = build,
	fields = {
		inventory_slot,
	},
}
