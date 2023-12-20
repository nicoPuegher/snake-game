local function generate_food()
	-- For conciseness
	local random = love.math.random

	-- Randomize a new location for the food
	Food.x = random(0, WINDOW_BLOCKS - 1) * Block_size
	Food.y = random(0, WINDOW_BLOCKS - 1) * Block_size

	-- Prevent the new food to spawn on top of the snake
	for _, block in ipairs(Snake) do
		if block.x == Food.x and block.y == Food.y then
			generate_food()
		end
	end
end

return generate_food
