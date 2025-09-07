extends CharacterState
func is_usable():
	return .is_usable() and host.charge == 5 and host.Overcharge and not host.OCT
func _tick():
	._tick()
	if current_tick % 1 == 0 and current_tick <= 36:
		host._create_speed_after_image("d70808", 0.2)
func _frame_10():
	host.start_invulnerability()
	host.grab_camera_focus()
	host.set_camera_zoom(0.85)
	host.opponent.hitlag_ticks = 50

func _frame_33():
		host.AchFail = true
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.unlock_achievement(host, "OC", true)
		if not data:
			host.play_sound("YharimRageSFX")
		host.OCT = true
		host.charge -= 5
		print("done")

func _exit():
	host.set_camera_zoom(1.0)
	host.release_camera_focus()
	host.end_invulnerability()
