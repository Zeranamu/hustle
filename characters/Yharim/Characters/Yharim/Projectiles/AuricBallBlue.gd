extends BaseProjectile
#hi


onready var EXPLOSION = load("res://Yharim/Characters/Yharim/Projectiles/BlueAuricExplosion.tscn")

var ticky = 0

func tick():
	.tick()
	ticky += 1
	if ticky >= 125:
		disable()

func disable():
	creator.shoot -= 1
	.disable()
