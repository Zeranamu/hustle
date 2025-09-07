extends CharacterState


func is_usable():
	return .is_usable() and host.charge >= 1

func _enter():
	host.AchFail = true
	host.charge -= 1

func _frame_4():
	host.has_hyper_armor = true
	host.start_projectile_invulnerability()

func _frame_5():
	if current_tick % 1 == 0 and current_tick <= 18:
		host._create_speed_after_image("74e7ff", 0.2)
	host.apply_force(data.x/24, data.y/24)

func _frame_8():
	host.has_hyper_armor = false
	host.end_projectile_invulnerability()
