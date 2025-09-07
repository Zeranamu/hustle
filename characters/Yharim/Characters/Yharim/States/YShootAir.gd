extends CharacterState

func is_usable():
	return .is_usable() and host.charge >= 1 and not host.install and host.shoot < 2

func _frame_5():
	host.AchFail = true
	host.charge -= 1
	host.shoot += 1
	if current_tick % 1 == 0 and current_tick <= 18:
		host._create_speed_after_image("74e7ff", 0.2)
