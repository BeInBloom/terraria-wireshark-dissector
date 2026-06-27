local uuid = ProtoField.string("terraria.client_uuid.uuid", "UUID")

---@param payload PayloadReader
local function build(payload)
	payload:string(uuid)
end

return {
	id = 68,
	build = build,
	fields = {
		uuid,
	},
}
