local string_reader = require("terraria.packet.readers.string_reader")

local M = {}

---@class NetworkTextFrame
---@field value TerrariaNetworkText
---@field start integer
---@field next_substitution integer

---@class NetworkTextReader
---@field reader ByteReader
---@field strings StringReader
local NetworkTextReader = {}
NetworkTextReader.__index = NetworkTextReader

---@param reader ByteReader
---@return NetworkTextReader
function M.new(reader)
	return setmetatable({
		reader = reader,
		strings = string_reader.new(reader),
	}, NetworkTextReader)
end

---@param mode integer
---@return integer
---@return TvbRange?
function NetworkTextReader:read_substitution_count(mode)
	if mode == 0 then
		return 0, nil
	end

	return self.reader:uint8()
end

---@return NetworkTextFrame
function NetworkTextReader:read_frame()
	local start = self.reader:position()
	local mode, mode_range = self.reader:uint8()
	local text, text_range = self.strings:read()
	local count, count_range = self:read_substitution_count(mode)
	local value = {
		mode = mode,
		text = text,
		substitutions = {},
		mode_range = mode_range,
		text_range = text_range,
		substitution_count = count,
		substitution_count_range = count_range,
		substitution_ranges = {},
	}

	return {
		start = start,
		next_substitution = 1,
		value = value,
	}
end

---@param frame NetworkTextFrame
---@return boolean
function NetworkTextReader:has_unread_substitutions(frame)
	return frame.next_substitution <= frame.value.substitution_count
end

---@param parent NetworkTextFrame
---@param value TerrariaNetworkText
---@param range TvbRange
function NetworkTextReader:add_substitution(parent, value, range)
	local index = parent.next_substitution
	parent.value.substitutions[index] = value
	parent.value.substitution_ranges[index] = range
	parent.next_substitution = index + 1
end

---@param stack NetworkTextFrame[]
---@return TerrariaNetworkText
---@return TvbRange
function NetworkTextReader:complete_frame(stack)
	local frame = table.remove(stack)
	local range = self.reader:range_from(frame.start)
	local parent = stack[#stack]

	if parent then
		self:add_substitution(parent, frame.value, range)
	end

	return frame.value, range
end

---@return TerrariaNetworkText
---@return TvbRange
function NetworkTextReader:read()
	local stack = { self:read_frame() }

	while #stack > 0 do
		local frame = stack[#stack]
		if self:has_unread_substitutions(frame) then
			stack[#stack + 1] = self:read_frame()
		else
			local value, range = self:complete_frame(stack)
			if #stack == 0 then
				return value, range
			end
		end
	end

	error("network text parser reached an invalid state")
end

return M
