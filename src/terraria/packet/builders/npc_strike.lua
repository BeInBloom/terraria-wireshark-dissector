local npc_id = ProtoField.int16("terraria.npc_strike.npc_id", "NPC ID", base.DEC)
local damage = ProtoField.int16("terraria.npc_strike.damage", "Damage", base.DEC)
local knockback = ProtoField.float("terraria.npc_strike.knockback", "Knockback")
local hit_direction = ProtoField.uint8("terraria.npc_strike.hit_direction", "Hit Direction", base.DEC)
local crit = ProtoField.bool("terraria.npc_strike.crit", "Crit")

---@param payload PayloadReader
local function build(payload)
	payload:int16_le(npc_id)
	payload:int16_le(damage)
	payload:single_le(knockback)
	payload:uint8(hit_direction)
	payload:bool(crit)
end

return {
	id = 28,
	build = build,
	fields = {
		npc_id,
		damage,
		knockback,
		hit_direction,
		crit,
	},
}
