-- Window/screen
local window_width, window_height

-- Player
local snake, block_width, block_height

-- Functions
local rectangle

-- Constants
local SIZE = 20
local INITIAL_SNAKE_SIZE = 3

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
end

function love.update() end

function love.draw() end
