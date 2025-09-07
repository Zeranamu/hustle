extends CharacterState

func is_usable():
	return .is_usable() and host.charge == 5 and not host.Crystal

onready var hitbox = $"%HitboxBeam" 
var shake = false

func _tick():
	._tick()
	if shake:
		hitbox.screenshake_amount = 0

func _frame_1():
	if host.touhou:
		timed_particle_scene = load ("res://Yharim/Characters/Yharim/Fx/Beams/BeamParticleEffectSPARK.tscn")
	if host.SKIN:
		timed_particle_scene = load ("res://Yharim/Characters/Yharim/Fx/Beams/BeamParticleEffectSKIN.tscn")
		hitbox.hit_particle = load ("res://Yharim/Characters/Yharim/Fx/Beams/BeamHitEffectSKIN.tscn")
	if host.LORDE:
		timed_particle_scene = load ("res://Yharim/Characters/Yharim/Fx/Beams/BeamParticleEffectLORDE.tscn")
	if host.AchSkin:
		timed_particle_scene = load("res://Yharim/Characters/Yharim/Fx/Beams/BeamParticleEffectSKIN2.tscn")
		hitbox.hit_particle = load ("res://Yharim/Characters/Yharim/Fx/Beams/BeamHitEffectSKIN2.tscn")
	host.hitlag_ticks += 5

var dead = false
var end = false

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj == host.opponent:
		if host.opponent.hp <= 10:
			dead = true
		if dead and not end:
			host.opponent.hp = 20


func _enter():
	host.grab_camera_focus()
	host.set_camera_zoom(0.85)

func _frame_14():
	host.charge -= 5
	host.AchFail = true
	host.start_invulnerability()
	host.opponent.hitlag_ticks = 50
	host.hitlag_ticks = 15
	if not host.SKIN:
		host.spawn_particle_effect_relative(host.BSTART, Vector2(0, 0))
	if host.SKIN:
		host.spawn_particle_effect_relative(host.BSTARTsk, Vector2(0, 0))
	if host.AchSkin and not host.SKIN:
		host.spawn_particle_effect_relative(host.BSTARTa, Vector2(0, 0))
	host.play_sound("CrystalSFX")

func _frame_30():
	host.set_camera_zoom(1.8)
	host.tween_camera_zoom(1.8, 2.0, 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	host.release_camera_focus()
	host.Crystal = true

func _frame_233():
	shake = true
	host.grab_camera_focus()
	host.set_camera_zoom(0.45)
	host.opponent.hitlag_ticks = 37
	if not host.SKIN and not host.LORDE:
		host.spawn_particle_effect_relative(host.BEND, Vector2(0, 0))
	if host.SKIN:
		host.spawn_particle_effect_relative(host.BENDsk, Vector2(0, 0))
	if host.LORDE:
		host.spawn_particle_effect_relative(host.BENDl, Vector2(0, 0))
	if host.AchSkin:
		host.spawn_particle_effect_relative(host.BENDa, Vector2(0, 0))
func _frame_270():
	if host.LORDE:
		host.play_sound("Squeak")
	if not dead:
		host.set_camera_zoom(1.0)
		host.release_camera_focus()
	end = true
func _frame_271():
	if dead and end:
		host.opponent.hp -= 9999999
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.unlock_achievement(host, "Beam", true)

func _exit():
	host.set_camera_zoom(1.0)
	host.release_camera_focus()
	host.stop_sound("CrystalSFX")
	end = false
	shake = false
	hitbox.screenshake_amount = 8
