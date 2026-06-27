local player_id = ProtoField.uint8(
	"terraria.number_of_angler_quests_completed.player_id",
	"Player ID",
	base.DEC
)
local quests_completed = ProtoField.int32(
	"terraria.number_of_angler_quests_completed.quests_completed",
	"Angler Quests Completed",
	base.DEC
)
local golfer_score = ProtoField.int32(
	"terraria.number_of_angler_quests_completed.golfer_score",
	"Golfer Score",
	base.DEC
)

---@param payload PayloadReader
local function build(payload)
	payload:uint8(player_id)
	payload:int32_le(quests_completed)
	payload:int32_le(golfer_score)
end

return {
	id = 76,
	build = build,
	fields = {
		player_id,
		quests_completed,
		golfer_score,
	},
}
