extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _pressed():
		$"%MusicPage".visible = true
		$"%Achivments".visible = false
		$"%Credits".visible = false
		$"%Info".visible = false
