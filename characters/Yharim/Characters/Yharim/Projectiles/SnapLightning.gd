extends DefaultFireball

var switch = false

onready var hitbox = $Hitbox

func _tick():
	if hitbox.overlaps(host.get_fighter().hurtbox) and not switch:
		host.creator.creator.charge += 1
		switch = true
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
#func _on_hit_something(obj, hitbox):
#	._on_hit_something(obj, hitbox)
#	if obj == host.creator.creator:
#		if host.creator.creator.current_state().get("hitstun") != null:
#			host.creator.creator.current_state().hitstun = 0
#		host.creator.creator.charge += 1

func _exit():
	switch = false
