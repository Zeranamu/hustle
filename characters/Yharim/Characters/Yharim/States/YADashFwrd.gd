extends CharacterState

func _enter():
	if data:
		if data.y == -1:
				host.change_state("YADashUp")
		if data.y == 1:
				host.change_state("YADashDwn")

func _frame_1():
		host._create_speed_after_image("ffffff", 0.2)
