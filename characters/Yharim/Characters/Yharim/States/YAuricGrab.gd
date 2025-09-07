extends CharacterState

func is_usable():
	return .is_usable() and host.charge >= 1

func _enter():
	host.AchFail = true
	host.charge -= 1

const MIN_SPEED = "15"
const MAX_SPEED = "35"

func _frame_4():
	if current_tick % 1 == 0 and current_tick <= 18:
		host._create_speed_after_image("74e7ff", 0.2)
	host.has_hyper_armor = true
	host.start_projectile_invulnerability()

func _frame_3():
	var amount = fixed.div(str(data.x), "100")
	amount = fixed.lerp_string(MIN_SPEED, MAX_SPEED, amount)
	host.apply_force_relative(amount, "0")

func _frame_11():
	host.has_hyper_armor = false
	host.end_projectile_invulnerability()
