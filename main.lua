-- Player
Snake = {}
Food = {}
Block_size = nil
Direction_queue = {}

-- Game
Timer = nil
Game_over = nil

-- Constants
WINDOW_DIMENSION = 700
WINDOW_BLOCKS = 20
INITIAL_SNAKE_SIZE = 3
local DELAY_DURATION = 0.15
MAP_EDGES = { start = 0, limit = WINDOW_DIMENSION }

-- Helper modules
require("./modules/user_input")
local initialize = require("./modules/initialize")
local update_snake = require("./modules/update_snake")

function love.load()
	initialize()
end

function love.update(dt)
	-- Accumulate time to control the speed of the snake
	Timer = Timer + dt

	-- When the timer exceedes the duration, there is room for an update
	if Timer >= DELAY_DURATION then
		update_snake()
	end
end

function love.draw()
	-- For conciseness
	local rectangle = love.graphics.rectangle
	local size = Block_size - 1

	-- Display game over screen
	if Game_over then
		-- Draw the game over title
		love.graphics.setColor(1, 0, 0)
		love.graphics.setFont(love.graphics.newFont(36))
		love.graphics.printf(
			"Game over, better luck next time!",
			0,
			WINDOW_DIMENSION / 2 - 50,
			WINDOW_DIMENSION,
			"center"
		)

		-- Draw the game over subtitle
		love.graphics.setColor(1, 1, 1)
		love.graphics.setFont(love.graphics.newFont(20))
		love.graphics.printf(
			"Please press Enter to restart and try again.",
			0,
			WINDOW_DIMENSION / 2 + 20,
			WINDOW_DIMENSION,
			"center"
		)

	-- Game is not over
	else
		-- Draw individual snake blocks
		for _, block in ipairs(Snake) do
			love.graphics.setColor(1, 1, 1)
			rectangle("fill", block.x, block.y, size, size)
		end

		-- Draw the food
		love.graphics.setColor(0, 1, 0)
		rectangle("fill", Food.x, Food.y, size, size)
	end
end
