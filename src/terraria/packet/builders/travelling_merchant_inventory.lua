local items = ProtoField.bytes(
	"terraria.travelling_merchant_inventory.items",
	"Items"
)
local item_fields = {}

for index = 1, 40 do
	item_fields[index] = ProtoField.int16(
		string.format("terraria.travelling_merchant_inventory.item_%02d", index),
		string.format("Item %02d", index),
		base.DEC
	)
end

---@param payload PayloadReader
local function build_items(payload)
	for index = 1, 40 do
		payload:int16_le(item_fields[index])
	end
end

---@param payload PayloadReader
local function build(payload)
	payload:group(items, "Items", build_items)
end

local fields = {
	items,
}

for index = 1, 40 do
	fields[#fields + 1] = item_fields[index]
end

return {
	id = 72,
	build = build,
	fields = fields,
}
