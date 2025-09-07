extends CharacterState

const MIN_SPEED = "20"
const MAX_SPEED = "30"

func _frame_1():
	var amount = fixed.div(str(data.x), "100")
	amount = fixed.lerp_string(MIN_SPEED, MAX_SPEED, amount)
	host.apply_force_relative(amount, "0")

func _frame_2():
	host.start_invulnerability()

func _frame_8():
	host.end_invulnerability()
