local Payload = {}
Payload.__index = Payload

---@param tvb TvbRange
---@return Payload
function Payload.new(tvb)
	return setmetatable({
		tvb = tvb,
	}, Payload)
end

---@return boolean
function Payload:is_valid()
	return true
end

return Payload
