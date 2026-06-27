local projectile_owner = ProtoField.uint16(
	"terraria.kill_portal.projectile_owner",
	"Projectile Owner",
	base.DEC
)
local projectile_ai = ProtoField.uint8(
	"terraria.kill_portal.projectile_ai",
	"Projectile AI",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint16_le(projectile_owner)
	payload:uint8(projectile_ai)
end

return {
	id = 95,
	build = build,
	fields = {
		projectile_owner,
		projectile_ai,
	},
}
