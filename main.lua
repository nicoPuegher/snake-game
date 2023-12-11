-- Player
local snake, block_size, direction

-- Game
local timer

-- Functions
local rectangle

-- Constants
local WINDOW_DIMENSION = 700
local WINDOW_BLOCK = 20
local INITIAL_SNAKE_SIZE = 3
local SNAKE_SPEED = 9
local DELAY_DURATION = 1 / SNAKE_SPEED
local MAP_EDGES = { start = 0, limit = WINDOW_DIMENSION }

function love.load()
	-- Set the window's size
	love.window.setMode(WINDOW_DIMENSION, WINDOW_DIMENSION)

	-- Calculate the size of a single block of the snake's body
	block_size = WINDOW_DIMENSION / WINDOW_BLOCK

	-- Initialize the snake's body
	snake = {}
	for i = 1, INITIAL_SNAKE_SIZE do
		local snake_body = {}
		snake_body.x = block_size * i
		snake_body.y = block_size
		table.insert(snake, snake_body)
	end

	-- Initialize the snake's direction
	direction = "right"

	-- Initialize accumulative timer
	timer = 0
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
			-- Teleport the snake to the left side of the map
			if snake_head.x == MAP_EDGES.limit then
				snake_head.x = MAP_EDGES.start - block_size
			end
			snake_head.x = snake_head.x + block_size
		elseif direction == "left" then
			-- Teleport the snake to the right side of the map
			if snake_head.x == MAP_EDGES.start then
				snake_head.x = MAP_EDGES.limit
			end
			snake_head.x = snake_head.x - block_size
		elseif direction == "up" then
			-- Teleport the snake to the bottom side of the map
			if snake_head.y == MAP_EDGES.start then
				snake_head.y = MAP_EDGES.limit
			end
			snake_head.y = snake_head.y - block_size
		elseif direction == "down" then
			-- Teleport the snake to the top side of the map
			if snake_head.y == MAP_EDGES.limit then
				snake_head.y = MAP_EDGES.start - block_size
			end
			snake_head.y = snake_head.y + block_size
		end

		-- Insert the new snake head and remove the tail
		table.insert(snake, snake_head)
		table.remove(snake, 1)

		-- Substract one frame from the accumulated time
		timer = timer - DELAY_DURATION
	end
end

function love.draw()
	-- For conciseness
	rectangle = love.graphics.rectangle

	-- Draw individual snake blocks
	for _, block in ipairs(snake) do
		rectangle("fill", block.x, block.y, block_size, block_size)
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
	end
end
