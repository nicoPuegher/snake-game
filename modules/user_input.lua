-- Change the snake's direction based on user input
function love.keypressed(key)
	-- For conciseness
	local q = Direction_queue[#Direction_queue]

	-- Prevent input repetition or wrong moves
	if key == "right" and q ~= "right" and q ~= "left" then
		table.insert(Direction_queue, "right")
	elseif key == "left" and q ~= "left" and q ~= "right" then
		table.insert(Direction_queue, "left")
	elseif key == "up" and q ~= "up" and q ~= "down" then
		table.insert(Direction_queue, "up")
	elseif key == "down" and q ~= "down" and q ~= "up" then
		table.insert(Direction_queue, "down")
	elseif key == "return" and Game_over then
		love.event.quit("restart")
	end
end
