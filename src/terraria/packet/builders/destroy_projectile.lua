local projectile_id = ProtoField.int16(
	"terraria.destroy_projectile.projectile_id",
	"Projectile ID",
	base.DEC
)
local owner = ProtoField.uint8("terraria.destroy_projectile.owner", "Owner", base.DEC)

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(projectile_id)
	payload:uint8(owner)
end

return {
	id = 29,
	build = build,
	fields = {
		projectile_id,
		owner,
	},
}
