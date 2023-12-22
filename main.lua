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
local draw = require("./modules/draw")

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
	-- Display game over screen
	if Game_over then
		draw.title()
		draw.subtitle()

	-- Game is not over
	else
		draw.snake()
		draw.food()
	end
end
