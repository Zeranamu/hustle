extends CharacterState

const MIN_SPEED = "5"
const MAX_SPEED = "15"


func _frame_1():
		var amount = fixed.div(str(data.x), "100")
		amount = fixed.lerp_string(MIN_SPEED, MAX_SPEED, amount)
		host.apply_force_relative(amount, "0")
		if not host.install:
			host._create_speed_after_image("ffffff", 0.2)
		if host.install:
			host._create_speed_after_image("d70808", 0.2)

