extends CharacterState

const MIN_SPEED = "10"
const MAX_SPEED = "30"

func _enter():
	if data.Button:
		host.change_state("YRollFollow", data.Distance)
		
func _frame_1():
	var amount = fixed.div(str(data.Distance.x), "100")
	amount = fixed.lerp_string(MIN_SPEED, MAX_SPEED, amount)
	host.apply_force_relative(amount, "0")
	host.start_projectile_invulnerability()

func _frame_2():
	host.start_invulnerability()

func _frame_11():
	host.end_invulnerability()
