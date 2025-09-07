extends ActionUIData

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
func _process(delta):
	if fighter.charge < 1:
		$"%Button".visible = false
