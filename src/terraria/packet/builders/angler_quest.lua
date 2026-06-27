local quest = ProtoField.uint8("terraria.angler_quest.quest", "Quest", base.DEC)
local completed = ProtoField.bool("terraria.angler_quest.completed", "Completed")

---@param payload PayloadReader
local function build(payload)
	payload:uint8(quest)
	payload:bool(completed)
end

return {
	id = 74,
	build = build,
	fields = {
		quest,
		completed,
	},
}
