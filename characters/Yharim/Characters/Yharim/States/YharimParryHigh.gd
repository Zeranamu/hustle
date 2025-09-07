extends GroundedParryState


func parry(p = true):
	.parry(p)
	if perfect and host.actions == 1:
		print("AchGet")
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.unlock_achievement(host, "intimidation", true)
