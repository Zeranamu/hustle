extends CharacterState

var can_apply_sadness = false

func _enter():
	can_apply_sadness = host.combo_count <= 0

func _frame_44():
	host.gain_super_meter_raw(host.MAX_SUPER_METER)
	host.unlock_achievement("ACH_HUSTLE", true)
	var codex_lib = get_node_or_null("/root/CharCodexLibrary")
	if is_instance_valid(codex_lib):
		codex_lib.unlock_achievement(host, "taunt")

