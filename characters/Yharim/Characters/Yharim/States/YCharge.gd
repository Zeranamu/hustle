extends CharacterState

var dat = false

func _enter():
	if data:
		dat = true

func is_usable():
	return .is_usable() and host.charge <= 5 and host.neu
	
func _frame_12():
		host.charge += 1
		host.neu = false

