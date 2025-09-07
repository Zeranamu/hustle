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
		$"%Shock".visible = fighter.install and fighter.charge >= 1
		return {
			$"%Shock": $"%Shock".pressed and $"%Shock".visible,
			$"%Distance": $"%Distance".pressed and $"%Distance".visible
		}
func on_button_selected():
	.on_button_selected()
	$"%Shock".visible = fighter.install and fighter.charge >= 1
