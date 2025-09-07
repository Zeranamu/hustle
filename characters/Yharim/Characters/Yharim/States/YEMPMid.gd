extends CharacterState

func _enter():
	if data:
		host.change_state("YPalmUp")


