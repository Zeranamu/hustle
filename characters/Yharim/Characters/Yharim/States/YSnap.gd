extends CharacterState
func _enter():
	host.switch = false

func is_usable():
	return .is_usable() and host.snap == 0

func _frame_11():
	host.snap += 48
	host.switch = true

const MAX_DISTANCE = "250"

func get_projectile_pos():

	var x = xy_to_dir(data.x, 0).x
	x = fixed.round(fixed.mul(x, MAX_DISTANCE)) * host.get_facing_int() + host.get_pos().x
	return {"x":x, "y":0}
