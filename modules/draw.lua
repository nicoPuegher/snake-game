-- Draw the game over title
local function title()
	love.graphics.setColor(1, 0, 0)
	love.graphics.setFont(love.graphics.newFont(30))
	love.graphics.printf(
		"Game over, better luck on your next time!",
		0,
		WINDOW_DIMENSION / 2 - 50,
		WINDOW_DIMENSION,
		"center"
	)
end

-- Draw the game over subtitle
local function subtitle()
	love.graphics.setColor(1, 1, 1)
	love.graphics.setFont(love.graphics.newFont(20))
	love.graphics.printf(
		"Please press Enter to restart and try again.",
		0,
		WINDOW_DIMENSION / 2 + 20,
		WINDOW_DIMENSION,
		"center"
	)
end

-- Draw individual snake blocks
local function snake()
	-- For conciseness
	local rectangle = love.graphics.rectangle
	local size = Block_size - 1

	for _, block in ipairs(Snake) do
		love.graphics.setColor(1, 1, 1)
		rectangle("fill", block.x, block.y, size, size)
	end
end

-- Draw the food
local function food()
	-- For conciseness
	local rectangle = love.graphics.rectangle
	local size = Block_size - 1

	love.graphics.setColor(0, 1, 0)
	rectangle("fill", Food.x, Food.y, size, size)
end

return { title = title, subtitle = subtitle, snake = snake, food = food }
