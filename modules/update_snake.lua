local snake_movement = require("./modules/snake_movement")
local collision = require("./modules/collision")

local function update_snake()
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

return update_snake
