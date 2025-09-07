extends PlayerExtra

onready var reduce = $Reduce

func _ready():
	reduce.connect("toggled", self, "_on_reduce_toggled")


func _on_reduce_toggled(_on):
	emit_signal("data_changed")


func get_extra():
	return{
		"Reduce" : reduce.pressed and reduce. visible
	}


func show_options():
	reduce.show() if fighter.snap > 0 and fighter.charge >= 1 else reduce.hide()


func reset():
	reduce.set_pressed_no_signal(false)
