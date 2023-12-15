-- Player
local snake, block_size, direction, food

-- Game
local timer, game_over

-- Functions
local random, generate_food, food_collision, snake_collision

-- Constants
local WINDOW_DIMENSION = 700
local WINDOW_BLOCKS = 20
local INITIAL_SNAKE_SIZE = 3
local SNAKE_SPEED = 9
local DELAY_DURATION = 1 / SNAKE_SPEED
local MAP_EDGES = { start = 0, limit = WINDOW_DIMENSION }

function love.load()
	-- Set the window's size
	love.window.setMode(WINDOW_DIMENSION, WINDOW_DIMENSION)

	-- Calculate the size of a single block of the snake's body
	block_size = WINDOW_DIMENSION / WINDOW_BLOCKS

	-- Initialize the snake's body (head first, tale last)
	snake = {}
	for i = INITIAL_SNAKE_SIZE, 1, -1 do
		local snake_body = {}
		snake_body.x = block_size * (i - 1)
		snake_body.y = block_size - block_size
		table.insert(snake, snake_body)
	end

	-- Initialize the snake's direction
	direction = "right"

	-- Initialize accumulative timer
	timer = 0

	-- Initialize the food
	food = {}
	generate_food()

	-- Initialize the game
	game_over = false
end

function love.update(dt)
	-- Accumulate time to control the speed of the snake
	timer = timer + dt

	-- When the timer exceedes the duration, there is room for an update
	while timer >= DELAY_DURATION do
		-- Create a new snake head
		local snake_head = { x = snake[#snake].x, y = snake[#snake].y }

		-- Move the new snake head based on the current direction
		if direction == "right" then
			snake_head.x = snake_head.x + block_size
			-- Teleport the snake to the left side of the map
			if snake_head.x == MAP_EDGES.limit then
				snake_head.x = MAP_EDGES.start
			end
		elseif direction == "left" then
			snake_head.x = snake_head.x - block_size
			-- Teleport the snake to the right side of the map
			if snake_head.x == MAP_EDGES.start - block_size then
				snake_head.x = MAP_EDGES.limit - block_size
			end
		elseif direction == "up" then
			snake_head.y = snake_head.y - block_size
			-- Teleport the snake to the bottom side of the map
			if snake_head.y == MAP_EDGES.start - block_size then
				snake_head.y = MAP_EDGES.limit - block_size
			end
		elseif direction == "down" then
			snake_head.y = snake_head.y + block_size
			-- Teleport the snake to the top side of the map
			if snake_head.y == MAP_EDGES.limit then
				snake_head.y = MAP_EDGES.start
			end
		end

		-- Check for collisions between the snake head and itself
		snake_collision(snake_head.x, snake_head.y)

		-- Check for collisions between the snake and the food
		food_collision(snake_head.x, snake_head.y)

		-- Insert the new snake head and remove the tail
		table.insert(snake, snake_head)
		table.remove(snake, 1)

		-- Substract one frame from the accumulated time
		timer = timer - DELAY_DURATION
	end
end

function love.draw()
	-- For conciseness
	local rectangle = love.graphics.rectangle
	local size = block_size - 1

	-- Display game over screen
	if game_over then
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
		for _, block in ipairs(snake) do
			love.graphics.setColor(1, 1, 1)
			rectangle("fill", block.x, block.y, size, size)
		end

		-- Draw the food
		love.graphics.setColor(0, 1, 0)
		rectangle("fill", food.x, food.y, block_size, block_size)
	end
end

function love.keypressed(key)
	-- Player inputs
	if key == "right" and direction ~= "left" then
		direction = "right"
	elseif key == "left" and direction ~= "right" then
		direction = "left"
	elseif key == "up" and direction ~= "down" then
		direction = "up"
	elseif key == "down" and direction ~= "up" then
		direction = "down"
	elseif key == "return" and game_over then
		love.event.quit("restart")
	end
end

function generate_food()
	-- For conciseness
	random = love.math.random

	-- Randomize a new location for the food
	food.x = random(0, WINDOW_BLOCKS - 1)
	food.y = random(0, WINDOW_BLOCKS - 1)
	food.x = food.x * block_size
	food.y = food.y * block_size

	-- Prevent the new food to spawn on top of the snake
	for _, block in ipairs(snake) do
		if block.x == food.x and block.y == food.y then
			generate_food()
		end
	end
end

function food_collision(x, y)
	-- Make the snake bigger after eating the food
	if x == food.x and y == food.y then
		table.insert(snake, { x = -block_size * 2, y = -block_size * 2 })

		-- Generate a new food with a different position
		generate_food()
	end
end

function snake_collision(x, y)
	-- Check if the snake hits itself
	for _, block in ipairs(snake) do
		if x == block.x and y == block.y then
			-- Game over
			game_over = true
		end
	end
end
