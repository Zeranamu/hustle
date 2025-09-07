extends CharacterState

func _frame_2():
	if host.install:
		host.apply_force(data.x/8, data.y/12)
	else:
		host.apply_force(data.x/10, data.y/14)
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj == host.opponent and host.install:
		var pos = host.opponent.get_pos()
		var objc = host.spawn_object(load("res://Yharim/Characters/Yharim/Projectiles/ShockProj.tscn"), pos.x, pos.y, false, null, false)
		objc.set_facing(host.get_facing_int())
