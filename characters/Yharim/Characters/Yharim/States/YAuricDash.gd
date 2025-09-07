extends CharacterState

func is_usable():
	return .is_usable() and host.charge >= 1 or host.install
func _tick():
	._tick()
	if current_tick % 1 == 0 and current_tick <= 18:
		host._create_speed_after_image("74e7ff", 0.2)
	if host.combo_count > 0:
		iasa_at = 7
	else:
		iasa_at = 14

const MIN_SPEED = "5"
const MAX_SPEED = "37"


func _frame_4():
	host.AchFail = true
	if not host.install:
		host.charge -= 1
	var amount = fixed.div(str(data.x), "100")
	amount = fixed.lerp_string(MIN_SPEED, MAX_SPEED, amount)
	host.apply_force_relative(amount, "0")
	

func _frame_6():
	host.start_invulnerability()

func _frame_8():
	host.end_invulnerability()


