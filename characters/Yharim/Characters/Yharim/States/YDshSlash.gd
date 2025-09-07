extends CharacterState

func _frame_2():
	host.start_throw_invulnerability()
func _frame_4():
	host.start_invulnerability()
func _frame_10():
	host.end_invulnerability()
	host.end_throw_invulnerability()

	
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj == host.opponent and host.OCT:
		var pos = host.opponent.get_pos()
		var objc = host.spawn_object(load("res://Yharim/Characters/Yharim/Projectiles/OCLighting.tscn"), pos.x, pos.y, false, null, false)
		objc.set_facing(host.get_facing_int())
