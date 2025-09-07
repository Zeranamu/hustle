extends CharacterState
onready var throw_box = $ThrowBox

const IS_GRAB = true
const DASH_LAG = 4
const DASH_SPEED = "14"
const JUMP_HEIGHT = "-10"

var dash_lag = 0
var dash_momentum_applied = false


func _frame_1():
	throw_techable = true

func _frame_9():
	throw_techable = false

func _tick():
	host.apply_fric()
	host.apply_grav()
	host.apply_forces()




