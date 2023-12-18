-- Player
local snake, block_size, direction_queue, food

-- Game
local timer, game_over

-- Functions
local add_movement, substract_movement, generate_food, food_collision, snake_collision

-- Constants
local WINDOW_DIMENSION = 700
local WINDOW_BLOCKS = 20
local INITIAL_SNAKE_SIZE = 3
local DELAY_DURATION = 0.15
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

	-- Initialize accumulative timer
	timer = 0

	-- Initialize the snake's direction
	direction_queue = { "right" }

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
	if timer >= DELAY_DURATION then
		-- Reset the timer
		timer = 0

		if #direction_queue > 1 then
			table.remove(direction_queue, 1)
		end

		-- Create a new snake head
		local snake_head = { x = snake[1].x, y = snake[1].y }

		-- Move the new snake head based on the current direction
		if direction_queue[1] == "right" then
			snake_head.x = add_movement(snake_head.x)
		elseif direction_queue[1] == "left" then
			snake_head.x = substract_movement(snake_head.x)
		elseif direction_queue[1] == "up" then
			snake_head.y = substract_movement(snake_head.y)
		elseif direction_queue[1] == "down" then
			snake_head.y = add_movement(snake_head.y)
		end

		-- Check for collisions between the snake head and itself
		snake_collision(snake_head.x, snake_head.y)

		-- Check for collisions between the snake and the food
		food_collision(snake_head.x, snake_head.y)

		-- Insert the new snake head and remove the tail
		table.insert(snake, 1, snake_head)
		table.remove(snake)
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

-- Change the snake's direction based on user input
function love.keypressed(key)
	-- For conciseness
	local q = direction_queue[#direction_queue]

	-- Prevent input repetition or wrong moves
	if key == "right" and q ~= "right" and q ~= "left" then
		table.insert(direction_queue, "right")
	elseif key == "left" and q ~= "left" and q ~= "right" then
		table.insert(direction_queue, "left")
	elseif key == "up" and q ~= "up" and q ~= "down" then
		table.insert(direction_queue, "up")
	elseif key == "down" and q ~= "down" and q ~= "up" then
		table.insert(direction_queue, "down")
	elseif key == "return" and game_over then
		love.event.quit("restart")
	end
end

-- Move the snake for right and down directions
function add_movement(new_head)
	new_head = new_head + block_size
	-- Teleport the snake to the opposite side of the map
	if new_head >= MAP_EDGES.limit then
		new_head = MAP_EDGES.start
	end
	return new_head
end

-- Move the snake for left and up directions
function substract_movement(new_head)
	new_head = new_head - block_size
	-- Teleport the snake to the opposite side of the map
	if new_head < MAP_EDGES.start then
		new_head = MAP_EDGES.limit - block_size
	end
	return new_head
end

function generate_food()
	-- For conciseness
	local random = love.math.random

	-- Randomize a new location for the food
	food.x = random(0, WINDOW_BLOCKS - 1) * block_size
	food.y = random(0, WINDOW_BLOCKS - 1) * block_size

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
