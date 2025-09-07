extends GroundedParryState


func parry(perfect = true):
	
	perfect = perfect and can_parry
	
	host.momentum += 60
	
	if perfect:
		enable_interrupt()
		host.set_block_stun(0)
		host.blocked_hitbox_plus_frames = 0
	else :
		parry_type = ParryHeight.Both
		host.start_throw_invulnerability()
	
	if name == "ParrySuper":
		anim_name = "ParrySuper"
	
	host.parried = true
	parried = true
	self.perfect = perfect
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	var spr_dir = host.get_facing_int()
	
	if perfect:
		host.set_camera_zoom(0.9)
		host.customzoom = 20
		host.tween_camera_zoom(0.9, 1.01, 0.4, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
		host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyParryFx.tscn"), Vector2(pos.x + 10*spr_dir,pos.y - 16), Vector2(host.get_facing_int(), 0))
		if abs(pos.x - opos.x) < 100 && abs(pos.y - opos.y) < 100:
			host.Frost += 60
		else:
			host.Frost += 30
		host.start_super(6)
	else :
		host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyBlockFx.tscn"), Vector2(pos.x + 10*spr_dir,pos.y - 16), Vector2(host.get_facing_int(), 0))
		if abs(pos.x - opos.x) < 100 && abs(pos.y - opos.y) < 100:
			host.Frost += 15
		else:
			host.Frost += 10
			
		
