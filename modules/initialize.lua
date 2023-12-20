local generate_food = require("./modules/generate_food")

local function initialize()
	-- Set the window's size
	love.window.setMode(WINDOW_DIMENSION, WINDOW_DIMENSION)

	-- Calculate the size of a single block of the snake's body
	Block_size = WINDOW_DIMENSION / WINDOW_BLOCKS

	-- Initialize the snake's body (head first, tale last)
	Snake = {}
	for i = INITIAL_SNAKE_SIZE, 1, -1 do
		local snake_body = {}
		snake_body.x = Block_size * (i - 1)
		snake_body.y = Block_size - Block_size
		table.insert(Snake, snake_body)
	end

	-- Initialize accumulative timer
	Timer = 0

	-- Initialize the snake's direction
	Direction_queue = { "right" }

	-- Initialize the food
	Food = {}
	generate_food()

	-- Initialize the game
	Game_over = false
end

return initialize
