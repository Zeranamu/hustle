extends CharacterState
func is_usable():
	return .is_usable() and host.timer == false and host.charge > 0

func _enter():
	host.AchFail = true
	host.timer = true
	if host.timer == false:
		print("not working")
	host.charge -= 1

const MIN_SPEED = "0"
const MAX_SPEED = "10"

func _frame_4():
	if current_tick % 1 == 0 and current_tick <= 18:
		host._create_speed_after_image("74e7ff", 0.2)
	host.has_hyper_armor = true

func _frame_8():
	host.has_hyper_armor = false
	var amount = fixed.div(str(data.x), "100")
	amount = fixed.lerp_string(MIN_SPEED, MAX_SPEED, amount)
	host.apply_force_relative(amount, "0")
