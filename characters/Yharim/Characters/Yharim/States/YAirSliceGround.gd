extends CharacterState

onready var hitbox = [$"%Hitbox21", $"%Hitbox31", $"%Hitbox41", $"%SpikeHitbox1", $"%Hitbox61", $"%Hitbox71"]

func _frame_1():
	for thing in hitbox:
		thing.damage_proration = (data.x / 10)

func _frame_2():
		host._create_speed_after_image("ffffff", 0.2)

func _frame_4():
	host.start_projectile_invulnerability()

func _frame_12():
	host.end_projectile_invulnerability()

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj == host.opponent and host.OCT:
		var pos = host.opponent.get_pos()
		var objc = host.spawn_object(load("res://Yharim/Characters/Yharim/Projectiles/OCLighting.tscn"), pos.x, pos.y, false, null, false)
		objc.set_facing(host.get_facing_int())
func _enter():
		host.apply_force(data.x, data.y/8)
