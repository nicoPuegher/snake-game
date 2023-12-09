-- Window/screen
local window_width, window_height

-- Player
local snake, block_width, block_height

-- Functions
local rectangle

-- Constants
local SIZE = 20

function love.load()
	-- Get window size
	window_width = love.graphics.getWidth()
	window_height = love.graphics.getHeight()

	-- Calculate the size of a single block of the snake's body
	block_width = window_width / SIZE
	block_height = window_height / SIZE
end

function love.update() end

function love.draw() end
