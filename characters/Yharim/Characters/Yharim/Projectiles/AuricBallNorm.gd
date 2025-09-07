extends BaseProjectile
#hi


onready var EXPLOSION = load("res://Yharim/Characters/Yharim/Projectiles/RedAuricExplosion.tscn")

var ticky = 0

func tick():
	.tick()
	ticky += 1
	if ticky >= 210:
		disable()

func disable():
	creator.shoot -= 1
	.disable()
