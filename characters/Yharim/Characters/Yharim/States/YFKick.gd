extends CharacterState
const MIN_SPEED = "5"
const MAX_SPEED = "25"


func _frame_2():
	var amount = fixed.div(str(data.x), "100")
	amount = fixed.lerp_string(MIN_SPEED, MAX_SPEED, amount)
	host.apply_force_relative(amount, "0")
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj == host.opponent and host.install:
		var pos = host.opponent.get_pos()
		var objc = host.spawn_object(load("res://Yharim/Characters/Yharim/Projectiles/ShockProj.tscn"), pos.x, pos.y, false, null, false)
		objc.set_facing(host.get_facing_int())
	if obj == host.opponent:
		host.reset_momentum()
