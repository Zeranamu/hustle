extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _pressed():
		$"%MusicPage".visible = false
		$"%Achivments".visible = true
		$"%Credits".visible = true
		$"%Info".visible = true
