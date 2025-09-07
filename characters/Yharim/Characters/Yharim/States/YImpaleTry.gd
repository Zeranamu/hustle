extends CharacterState

onready var hb = $Hitbox2

func _enter():
	if host.reverse_state:
		host.reset_momentum()
	if data:
		hb.followup_state = "YImpaleYesUp"
	else:
		hb.followup_state = "YImpaleYes"

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj == host.opponent and host.OCT:
		var pos = host.opponent.get_pos()
		var objc = host.spawn_object(load("res://Yharim/Characters/Yharim/Projectiles/OCLighting.tscn"), pos.x, pos.y, false, null, false)
		objc.set_facing(host.get_facing_int())
