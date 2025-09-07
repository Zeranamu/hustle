extends CharacterState

var hits = 0

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj == host.opponent and host.OCT and hits <= 2:
		var pos = host.opponent.get_pos()
		var objc = host.spawn_object(load("res://Yharim/Characters/Yharim/Projectiles/OCLighting.tscn"), pos.x, pos.y, false, null, false)
		objc.set_facing(host.get_facing_int())
		hits += 1
func _exit():
	hits == 0
