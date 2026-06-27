local M = {}

---@param field ProtoField
---@param read fun(payload: PayloadReader)
function M:group(field, read)
	local start = self.reader:position()
	local item = self.tree:add(field, self.reader.source:range(start, self.reader:remaining()))
	local payload = self.__index.new(self.reader, item)

	local ok, err = pcall(read, payload)

	item:set_len(self.reader:position() - start)

	if not ok then
		error(err, 0)
	end
end

return M
