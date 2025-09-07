extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _pressed():
	$"%AchInfo".visible = false
	$"%Credits".visible = true
	$"%Info".visible = true
	$"%Settings".visible = true
