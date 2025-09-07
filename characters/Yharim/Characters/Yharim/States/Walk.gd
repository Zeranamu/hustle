extends CharacterState


func _tick():
	._tick()
	if current_tick == 20 and !host.is_ghost:
		current_tick = 1 
func _frame_1():
	if not host.install:
		host._create_speed_after_image("ffffff", 0.5)
	if host.install:
		host._create_speed_after_image("d70808", 0.5)

