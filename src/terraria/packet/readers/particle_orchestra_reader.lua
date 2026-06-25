local vector2_reader = require("terraria.packet.readers.vector2_reader")

local M = {}

---@class ParticleOrchestraReader
---@field reader ByteReader
---@field vectors Vector2Reader
local ParticleOrchestraReader = {}
ParticleOrchestraReader.__index = ParticleOrchestraReader

---@param reader ByteReader
---@return ParticleOrchestraReader
function M.new(reader)
	return setmetatable({
		reader = reader,
		vectors = vector2_reader.new(reader),
	}, ParticleOrchestraReader)
end

---@return TerrariaParticleOrchestra
---@return TvbRange
function ParticleOrchestraReader:read()
	local start = self.reader:position()
	local position, position_range = self.vectors:read()
	local movement, movement_range = self.vectors:read()
	local shader, shader_range = self.reader:int32_le()
	local player_id, player_id_range = self.reader:uint8()

	return {
		position = position,
		movement = movement,
		packed_shader_index = shader,
		invoking_player_id = player_id,
		position_range = position_range,
		movement_range = movement_range,
		packed_shader_index_range = shader_range,
		invoking_player_id_range = player_id_range,
	}, self.reader:range_from(start)
end

return M
