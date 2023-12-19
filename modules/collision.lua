local generate_food = require("./modules/generate_food")

local function food(x, y)
	-- Make the snake bigger after eating the food
	if x == Food.x and y == Food.y then
		table.insert(Snake, { x = -Block_size * 2, y = -Block_size * 2 })

		-- Generate a new food with a different position
		generate_food()
	end
end

local function snake(x, y)
	-- Check if the snake hits itself
	for _, block in ipairs(Snake) do
		if x == block.x and y == block.y then
			-- Game over
			Game_over = true
		end
	end
end

return { food = food, snake = snake }
