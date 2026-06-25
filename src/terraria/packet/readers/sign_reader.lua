local string_reader = require("terraria.packet.readers.string_reader")

local M = {}

---@class SignReader
---@field reader ByteReader
---@field strings StringReader
local SignReader = {}
SignReader.__index = SignReader

---@param reader ByteReader
---@return SignReader
function M.new(reader)
	return setmetatable({
		reader = reader,
		strings = string_reader.new(reader),
	}, SignReader)
end

---@return TerrariaSign
---@return TvbRange
function SignReader:read()
	local start = self.reader:position()
	local id, id_range = self.reader:int16_le()
	local x, x_range = self.reader:int16_le()
	local y, y_range = self.reader:int16_le()
	local text, text_range = self.strings:read()

	return {
		id = id,
		x = x,
		y = y,
		text = text,
		id_range = id_range,
		x_range = x_range,
		y_range = y_range,
		text_range = text_range,
	}, self.reader:range_from(start)
end

return M
