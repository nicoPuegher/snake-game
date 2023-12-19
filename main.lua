-- Player variables
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
local snake_movement = require("./modules/snake_movement")
require("./modules/user_input")
local collision = require("./modules/collision")
local initialize = require("./modules/initialize")

function love.load()
	initialize()
end

function love.update(dt)
	-- Accumulate time to control the speed of the snake
	Timer = Timer + dt

	-- When the timer exceedes the duration, there is room for an update
	if Timer >= DELAY_DURATION then
		-- Reset the timer
		Timer = 0

		if #Direction_queue > 1 then
			table.remove(Direction_queue, 1)
		end

		-- Create a new snake head
		local snake_head = { x = Snake[1].x, y = Snake[1].y }

		-- Move the new snake head based on the current direction
		if Direction_queue[1] == "right" then
			snake_head.x = snake_movement.add(snake_head.x)
		elseif Direction_queue[1] == "left" then
			snake_head.x = snake_movement.substract(snake_head.x)
		elseif Direction_queue[1] == "up" then
			snake_head.y = snake_movement.substract(snake_head.y)
		elseif Direction_queue[1] == "down" then
			snake_head.y = snake_movement.add(snake_head.y)
		end

		-- Check for collisions between the snake head and itself
		collision.snake(snake_head.x, snake_head.y)

		-- Check for collisions between the snake and the food
		collision.food(snake_head.x, snake_head.y)

		-- Insert the new snake head and remove the tail
		table.insert(Snake, 1, snake_head)
		table.remove(Snake)
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
