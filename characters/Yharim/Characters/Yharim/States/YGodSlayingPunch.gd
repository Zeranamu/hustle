extends CharacterState

func is_usable():
	return .is_usable() and host.timer == false and host.charge > 3 and host.install

func _enter():
	host.AchFail = true
	host.GSP = true
	host.timer = true
	if host.timer == false:
		print("not working")
	host.charge -= 1

const MIN_SPEED = "15"
const MAX_SPEED = "35"

func _tick():
	._tick()
	if current_tick % 1 == 0 and current_tick <= 26:
		host._create_speed_after_image("d70808", 0.2)

func _frame_4():
	if current_tick % 1 == 0 and current_tick <= 22:
		host._create_speed_after_image("d70808", 0.2)
	host.start_projectile_invulnerability()
func _frame_8():
	host.has_hyper_armor = true

func _frame_14():
	host.opponent.hitlag_ticks += 8
	host.grab_camera_focus()
	host.has_hyper_armor = false
	var amount = fixed.div(str(data.x), "100")
	amount = fixed.lerp_string(MIN_SPEED, MAX_SPEED, amount)
	host.apply_force_relative(amount, "0")

func _frame_9():
	host.start_invulnerability()
func _frame_22():
	host.end_projectile_invulnerability()
	host.end_invulnerability()
func _exit():
	if host.opponent.hp <= 0:
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.unlock_achievement(host, "Devourer", true)
	host.release_camera_focus()
	host.GSP = false

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if host.opponent.hp <= 0:
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.unlock_achievement(host, "Devourer", true)
