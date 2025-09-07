extends DefaultFireball

var hits = 0

func _on_hit_something(obj, hitbox):
	if obj and obj.is_in_group("Fighter"):
		hits += 1
	if hits == 1:
		disable()
	._on_hit_something(obj, hitbox)
