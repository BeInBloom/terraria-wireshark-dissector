local M = {}

---@class ByteReader
---@field source TvbRange
---@field cursor integer
local ByteReader = {}
ByteReader.__index = ByteReader

---@param source TvbRange
---@return ByteReader
function M.new(source)
	return setmetatable({
		source = source,
		cursor = 0,
	}, ByteReader)
end

---@return integer
function ByteReader:position()
	return self.cursor
end

---@return integer
function ByteReader:remaining()
	return self.source:len() - self.cursor
end

---@param len integer
---@return TvbRange
function ByteReader:range(len)
	assert(len >= 0, "byte reader range length must be non-negative")
	assert(
		self:remaining() >= len,
		string.format(
			"byte reader out of bounds: position=%d len=%d remaining=%d",
			self.cursor,
			len,
			self:remaining()
		)
	)

	local range = self.source:range(self.cursor, len)
	self.cursor = self.cursor + len
	return range
end

---@param start integer
---@return TvbRange
function ByteReader:range_from(start)
	assert(start >= 0, "byte reader range start must be non-negative")
	assert(start <= self.cursor, "byte reader range start is after cursor")
	return self.source:range(start, self.cursor - start)
end

---@return integer
---@return TvbRange
function ByteReader:uint8()
	local range = self:range(1)
	return range:uint(), range
end

---@return integer
---@return TvbRange
function ByteReader:sbyte()
	local range = self:range(1)
	return range:int(), range
end

---@return integer
---@return TvbRange
function ByteReader:uint16_le()
	local range = self:range(2)
	return range:le_uint(), range
end

---@return integer
---@return TvbRange
function ByteReader:int16_le()
	local range = self:range(2)
	return range:le_int(), range
end

---@return integer
---@return TvbRange
function ByteReader:uint32_le()
	local range = self:range(4)
	return range:le_uint(), range
end

---@return integer
---@return TvbRange
function ByteReader:int32_le()
	local range = self:range(4)
	return range:le_int(), range
end

---@return UInt64
---@return TvbRange
function ByteReader:uint64_le()
	local range = self:range(8)
	return range:le_uint64(), range
end

---@return number
---@return TvbRange
function ByteReader:single_le()
	local range = self:range(4)
	return range:le_float(), range
end

---@return boolean
---@return TvbRange
function ByteReader:bool()
	local value, range = self:uint8()
	return value ~= 0, range
end

---@param len integer
---@return string
---@return TvbRange
function ByteReader:bytes(len)
	local range = self:range(len)
	return range:raw(), range
end

return M
