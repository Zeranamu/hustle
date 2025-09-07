extends TextureButton


# Declare member variables here. Examples:
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _pressed():
		$"%ScrollContainer".visible = true
		$"%Settings".visible = false
		$"%Achivments".visible = false
		$"%Credits".visible = false
