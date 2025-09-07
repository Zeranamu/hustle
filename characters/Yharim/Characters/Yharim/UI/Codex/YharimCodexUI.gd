extends Control



func play_sound(sound_name):
	if $Sounds.has_node(sound_name):
		$Sounds.get_node(sound_name).play()

func stop_sound(sound_name):
	if $Sounds.has_node(sound_name):
		$Sounds.get_node(sound_name).stop()

func get_data():
		var children = get_children()
		if children.size() == 1:
			return children[0].get_data()
		elif children.size() == 0:
			return null
		else :
			var data = {}
			for child in children:
				if child.name != "CPUParticles2D":
					data[child.name] = child.get_data()
			return data
			

func _ready():
	$"%Credits".connect("pressed", self, "on_any_button_pressed")
	$"%Info".connect("pressed", self, "on_any_button_pressed")
	$"%Settings".connect("pressed", self, "on_any_button_pressed")
	$"%Achivments".connect("pressed", self, "on_any_button_pressed")
	$"%Credits".connect("mouse_entered", self, "on_hover")
	$"%Info".connect("mouse_entered", self, "on_hover")
	$"%Settings".connect("mouse_entered", self, "on_hover")
	$"%Achivments".connect("mouse_entered", self, "on_hover")
	$"%CreditExit".connect("pressed", self, "on_button_exit")
	$"%InfoExit".connect("pressed", self, "on_button_exit")
	$"%MusicExit".connect("pressed", self, "on_button_exit")
	$"%AchExit".connect("pressed", self, "on_button_exit")
	$"%OST1".connect("toggled", self, "_on_OST1_toggled")
	$"%OST3".connect("toggled", self, "_on_OST3_toggled")

func on_hover():
	play_sound("MenuClick")

func on_any_button_pressed():
	play_sound("MenuOpen")

func on_button_exit():
	play_sound("MenuClose")

func _on_OST1_toggled(button_pressed):
	if button_pressed:
		play_sound("YharimOST")
	else:
		stop_sound("YharimOST")

func _on_OST3_toggled(button_pressed):
	if button_pressed:
		play_sound("OST3")
	else:
		stop_sound("OST3")
