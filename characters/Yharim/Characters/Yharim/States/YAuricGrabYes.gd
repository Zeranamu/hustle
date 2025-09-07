extends ThrowState

func _enter():
	host.opponent.grab_camera_focus()
	host.play_sound("AhShit")
func _frame_1():
	host.charge += 1
func _frame_21():
	host.opponent.release_camera_focus()
