extends CharacterState

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj == host.opponent and host.install:
		var pos = host.opponent.get_pos()
		var objc = host.spawn_object(load("res://Yharim/Characters/Yharim/Projectiles/ShockProj.tscn"), pos.x, pos.y, false, null, false)
		objc.set_facing(host.get_facing_int())
