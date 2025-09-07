extends CharacterState

const MIN_SPEED = "15"
const MAX_SPEED = "28"
var yes = false

func _frame_3():
	var amount = fixed.div(str(data.x), "100")
	amount = fixed.lerp_string(MIN_SPEED, MAX_SPEED, amount)
	host.apply_force_relative(amount, "0")


func _frame_4():
	if host.initiative:
		host.start_projectile_invulnerability()

func _frame_13():
	yes = true

func _frame_16():
	host.end_projectile_invulnerability()

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj == host.opponent and host.OCT and yes:
		var pos = host.opponent.get_pos()
		var objc = host.spawn_object(load("res://Yharim/Characters/Yharim/Projectiles/OCLighting.tscn"), pos.x, pos.y, false, null, false)
		objc.set_facing(host.get_facing_int())
func _exit():
	yes = false
