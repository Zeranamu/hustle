extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _pressed():
	$"%AchInfo".visible = true
	$"%Credits".visible = false
	$"%Info".visible = false
	$"%Settings".visible = false
