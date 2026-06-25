local player_id = ProtoField.uint8("terraria.player_info.player_id", "Player ID", base.DEC)
local skin_variant = ProtoField.uint8(
	"terraria.player_info.skin_variant",
	"Skin Variant",
	base.DEC
)
local hair = ProtoField.uint8("terraria.player_info.hair", "Hair", base.DEC)
local name = ProtoField.string("terraria.player_info.name", "Name")
local hair_dye = ProtoField.uint8("terraria.player_info.hair_dye", "Hair Dye", base.DEC)
local hide_visuals = ProtoField.uint8(
	"terraria.player_info.hide_visuals",
	"Hide Visuals",
	base.HEX
)
local hide_visuals_2 = ProtoField.uint8(
	"terraria.player_info.hide_visuals_2",
	"Hide Visuals 2",
	base.HEX
)
local hide_misc = ProtoField.uint8(
	"terraria.player_info.hide_misc",
	"Hide Misc",
	base.HEX
)
local hair_color = ProtoField.bytes("terraria.player_info.hair_color", "Hair Color")
local skin_color = ProtoField.bytes("terraria.player_info.skin_color", "Skin Color")
local eye_color = ProtoField.bytes("terraria.player_info.eye_color", "Eye Color")
local shirt_color = ProtoField.bytes("terraria.player_info.shirt_color", "Shirt Color")
local under_shirt_color = ProtoField.bytes(
	"terraria.player_info.under_shirt_color",
	"Under Shirt Color"
)
local pants_color = ProtoField.bytes("terraria.player_info.pants_color", "Pants Color")
local shoe_color = ProtoField.bytes("terraria.player_info.shoe_color", "Shoe Color")
local difficulty_flags = ProtoField.uint8(
	"terraria.player_info.difficulty_flags",
	"Difficulty Flags",
	base.HEX
)
local torch_flags = ProtoField.uint8(
	"terraria.player_info.torch_flags",
	"Torch Flags",
	base.HEX
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:uint8(skin_variant)
	payload:uint8(hair)
	payload:string(name)
	payload:uint8(hair_dye)
	payload:uint8(hide_visuals)
	payload:uint8(hide_visuals_2)
	payload:uint8(hide_misc)
	payload:color(hair_color)
	payload:color(skin_color)
	payload:color(eye_color)
	payload:color(shirt_color)
	payload:color(under_shirt_color)
	payload:color(pants_color)
	payload:color(shoe_color)
	payload:uint8(difficulty_flags)
	payload:uint8(torch_flags)
end

return {
	id = 4,
	build = build,
	fields = {
		player_id,
		skin_variant,
		hair,
		name,
		hair_dye,
		hide_visuals,
		hide_visuals_2,
		hide_misc,
		hair_color,
		skin_color,
		eye_color,
		shirt_color,
		under_shirt_color,
		pants_color,
		shoe_color,
		difficulty_flags,
		torch_flags,
	},
}
