local monster_types = ProtoField.bytes(
	"terraria.sync_cavern_monster_type.monster_types",
	"Monster Types"
)
local monster_type_fields = {}

for index = 1, 6 do
	monster_type_fields[index] = ProtoField.uint16(
		string.format("terraria.sync_cavern_monster_type.monster_type_%d", index),
		string.format("Monster Type %d", index),
		base.DEC
	)
end

---@param payload PayloadReader
local function build_monster_types(payload)
	for index = 1, 6 do
		payload:uint16_le(monster_type_fields[index])
	end
end

---@param payload PayloadReader
local function build(payload)
	payload:group(monster_types, build_monster_types)
end

local fields = {
	monster_types,
}

for index = 1, 6 do
	fields[#fields + 1] = monster_type_fields[index]
end

return {
	id = 136,
	build = build,
	fields = fields,
}
