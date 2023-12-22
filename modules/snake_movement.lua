-- Move the snake for right and down directions
local function add(new_head)
	new_head = new_head + Block_size
	-- Teleport the snake to the opposite side of the map
	if new_head >= MAP_EDGES.limit then
		new_head = MAP_EDGES.start
	end
	return new_head
end

-- Move the snake for left and up directions
local function substract(new_head)
	new_head = new_head - Block_size
	-- Teleport the snake to the opposite side of the map
	if new_head < MAP_EDGES.start then
		new_head = MAP_EDGES.limit - Block_size
	end
	return new_head
end

return { add = add, substract = substract }
