local password = ProtoField.string("terraria.send_password.password", "Password")

---@param payload PayloadReader
local function build(payload)
	payload:string(password)
end

return {
	id = 38,
	build = build,
	fields = {
		password,
	},
}
