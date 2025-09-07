extends BaseProjectile


func get_camera():
	var cameras = get_tree().get_nodes_in_group("Camera")
	return cameras[0] if cameras.size() > 0 and not is_ghost else null

func grab_camera_focus():
	var camera = get_camera()
	if camera:
		camera.focused_object = self

func release_camera_focus():
	var camera = get_camera()
	if camera:
		camera.focused_object = null
