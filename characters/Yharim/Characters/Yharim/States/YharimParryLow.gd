extends GroundedParryState

func _frame_0():
	._frame_0()
	if host.actions == 1:
		if perfect:
			print("AchGet")
			var codex_lib = get_node_or_null("/root/CharCodexLibrary")
			if is_instance_valid(codex_lib):
				codex_lib.unlock_achievement(host, "intimidation", true)
