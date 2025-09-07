extends CharacterState

onready var ACH = host.get_node("%AchBack")

func _frame_1():
	if data.BG and host.AchSkin and not host.SKIN:
		projectile_scene = load("res://Yharim/Characters/Yharim/Projectiles/ZoomProjectile.tscn")

func is_usable():
	return .is_usable() and host.charge == 3 and not host.install
func _tick():
	._tick()
	if current_tick % 1 == 0 and current_tick <= 36:
		host._create_speed_after_image("d70808", 0.2)
func _frame_10():
	if data.BG and host.AchSkin and not host.SKIN:
		host.spawn_particle_effect(host.INSTALLBGACHSTART, Vector2(0, 0))
		host.set_camera_zoom(0.85)
		host.start_invulnerability()
		host.opponent.hitlag_ticks = 50
	else:
		host.start_invulnerability()
		host.grab_camera_focus()
		host.set_camera_zoom(0.85)
		host.opponent.hitlag_ticks = 50
func _frame_33():
		if not data.shh:
			host.play_sound("InstallEnter")
		if not data.shh and host.AchSkin and host.SKIN and not data.Music:
			host.play_sound("SkinSFXLoop")
		if not data.shh and host.AchSkin and not host.SKIN and not data.Music:
			host.play_sound("AchSkinSFX")
		if data.Music:
			host.play_sound("InstallMusic")
		host.install = true
		if data.BG and not host.SKIN:
			host.spawn_particle_effect(host.INSTALLBG, Vector2(0, 0))
		if data.BG and host.SKIN:
			host.spawn_particle_effect(host.INSTALLBGSPECIAL, Vector2(0, 0))
		if data.BG and host.AchSkin and not host.SKIN:
			host.spawn_particle_effect(host.INSTALLBGACH, Vector2(0, 0))
		host.charge += 1
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib) and Network.multiplayer_active:
			codex_lib.unlock_achievement(host, "Install")


func _exit():
	if data.BG and host.AchSkin and not host.SKIN:
		
		host.release_camera_focus()
		host.end_invulnerability()
		host.set_camera_zoom(1.0)
	else:
		host.set_camera_zoom(1.0)
		host.release_camera_focus()
		host.end_invulnerability()
