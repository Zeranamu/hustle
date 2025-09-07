extends DefaultFireball

var hits = 0
var ticky = 0

func _tick():
	._tick()
	ticky += 1
	if ticky >= 125:
		var obj1 = host.spawn_object(host.EXPLOSION, 0, 0, true, data)
		obj1.set_facing(host.get_facing_int())
		hits = 0
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj and obj.is_in_group("Fighter") and obj == host.creator.opponent:
		hits += 1
	if hits == 2:
		host.creator.current_state().enable_hit_cancel()
		var obj1 = host.spawn_object(host.EXPLOSION, 0, 0, true, data)
		obj1.set_facing(host.get_facing_int())
		hits = 0

