extends CharacterState

func _frame_0():
	host.charge -= 1
func _frame_1():
	if current_tick % 1 == 0 and current_tick <= 18:
		host._create_speed_after_image("74e7ff", 0.2)
