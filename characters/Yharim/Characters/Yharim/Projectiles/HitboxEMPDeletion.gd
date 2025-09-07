extends ObjectState

onready var hitbox = $Hitbox

func _tick():
	if not host.disabled:
		._tick()
		for obj in host.objs_map.values():
			if obj == host:
				continue
			if not is_instance_valid(obj):
				continue
			if obj.is_in_group("Fighter"):
				continue
			if obj.disabled == true:
				continue
			if hitbox.overlaps(obj.hurtbox):
				hitbox.hit(obj)
				host.trigger_consume(obj)
	

func _frame_3():
	host.disable()
	terminate_hitboxes()
