extends CharacterState

func is_usable():
	return .is_usable() and host.charge >= 1


func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
func _frame_1():
		host.AchFail = true
		host.charge -= 1
		
func _frame_5():
	if host.install:
		host.apply_force(data.x/7, data.y/8)
	else:
		host.apply_force(data.x/9, data.y/10)
