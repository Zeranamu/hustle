extends CharacterState

const MIN_SPEED = "13"
const MAX_SPEED = "35"

func _enter():
	if data.Button:
		host.change_state("YPokeFollow", data.Distance)

func _frame_3():
	var amount = fixed.div(str(data.Distance.x), "100")
	amount = fixed.lerp_string(MIN_SPEED, MAX_SPEED, amount)
	host.apply_force_relative(amount, "0")


func _frame_2():
	if host.initiative:
		host.start_projectile_invulnerability()

func _frame_16():
	host.end_projectile_invulnerability()

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj == host.opponent:
		host.reset_momentum()
	if obj == host.opponent and host.install:
		var pos = host.opponent.get_pos()
		var objc = host.spawn_object(load("res://Yharim/Characters/Yharim/Projectiles/ShockLighting.tscn"), pos.x, pos.y, false, null, false)
		objc.set_facing(host.get_facing_int())
