extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _pressed():
		$"%ScrollContainer".visible = false
		$"%Settings".visible = true
		$"%Achivments".visible = true
		$"%Credits".visible = true
