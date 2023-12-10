-- Window/screen
local window_width, window_height

-- Player
local snake, block_width, block_height, direction

-- Game
local timer

-- Functions
local rectangle

-- Constants
local SIZE = 20
local INITIAL_SNAKE_SIZE = 3
local SNAKE_SPEED = 9
local DURATION = 1 / SNAKE_SPEED

function love.load()
	-- Get window size
	window_width = love.graphics.getWidth()
	window_height = love.graphics.getHeight()

	-- Calculate the size of a single block of the snake's body
	block_width = window_width / SIZE
	block_height = window_height / SIZE

	-- Initialize the snake's body
	snake = {}
	for i = 1, INITIAL_SNAKE_SIZE do
		local snake_body = {}
		snake_body.x = block_width * i
		snake_body.y = block_height
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
	while timer >= DURATION do
		-- Create a new snake head
		local snake_head = { x = snake[#snake].x, y = snake[#snake].y }

		-- Move the new snake head based on the current direction
		if direction == "right" then
			snake_head.x = snake_head.x + block_width
		elseif direction == "left" then
			snake_head.x = snake_head.x - block_width
		elseif direction == "up" then
			snake_head.y = snake_head.y - block_height
		elseif direction == "down" then
			snake_head.y = snake_head.y + block_height
		end

		-- Insert the new snake head and remove the tail
		table.insert(snake, snake_head)
		table.remove(snake, 1)

		-- Substract one frame from the accumulated time
		timer = timer - DURATION
	end
end

function love.draw()
	-- For conciseness
	rectangle = love.graphics.rectangle

	-- Draw individual snake blocks
	for _, block in ipairs(snake) do
		rectangle("fill", block.x, block.y, block_width, block_height)
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
