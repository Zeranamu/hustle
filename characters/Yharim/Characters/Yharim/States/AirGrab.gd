extends CharacterState

onready var throw_box = $ThrowBox

const IS_GRAB = true
const DASH_LAG = 4
const DASH_SPEED = "14"
const JUMP_HEIGHT = "-10"

export  var jump_grab = false

export  var forward_throw_state = "ForwardThrow"
export  var back_throw_state = "BackThrow"
export  var down_throw_state = "AirDownThrow"

var dash_lag = 0
var dash_momentum_applied = false

