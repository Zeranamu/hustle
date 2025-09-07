extends CharacterState

var hitted = 0
var woohoo = false
var oldface = 0
var fakehithold = 0
var hittick = 0 
var oldpos = Vector2()
var ooldpos = Vector2()
var realtick = 0
var countering = false
var oopos = 0

func _exit():
	if name == "Warhead":
		host.release_camera_focus()
		
func is_usable():
	var sname = host.current_state().name
	
	if editor_description == "ICE":
		return .is_usable() and !host.hasscythe
		
	if (type == 2 or name == "Treason") and name != "Walk2" and name != "Walk3" and name != "Domination" and name != "Tyranny2" and name != "Tyranny":
		return .is_usable() and host.hasscythe
		
	if name == "Freeze Time":
		if host.opponent.get("overtime"):
			return .is_usable() and host.opponent.overtime > 0 and host.burst_meter > 200
		else:
			return false
			
	if name == "Isolate" or name == "Isolate2":
		return .is_usable() and host.Frost >= 555 && host.Frost < 666
		
	if name == "Withdraw":
		return .is_usable() and host.hasscythe
	if name == "Toss":
		return .is_usable() and host.hasscythe
		
	if name == "Recall":
		return .is_usable() and !host.hasscythe
		
	if name == "Toss2": 
		return .is_usable() and (sname == "Breach" or sname == "Withdraw") and host.hasscythe
		
	if name == "Domination": 
		return .is_usable() and sname != "Withdraw" and host.hasscythe and host.get_pos().y >= -65
		
	if name == "Terrorize":
		return .is_usable() and (sname == "Walk" or sname == "Walk2" or sname == "Walk3" or sname == "Landing" or sname == "Warhead") and host.momentum > 40
	
	if type == 1:
		return .is_usable() and host.frostbite < 6
		
	if name == "Tyranny":
		return .is_usable() and host.frostbite < 6 and host.hasscythe
		
	if name == "Walk2" or name == "Walk3":
		return .is_usable() and host.frostbite < 6
		
	if name == "Back Hand2":
		return .is_usable() and host.frostbite >= 6
		
	if name == "Tyranny2":
		return .is_usable() and host.frostbite >= 6 and host.hasscythe
		
	if host.combo_count > 0:
		return .is_usable() and sname != name
		
	return .is_usable()
	
func start():
	if name == "Treason":
		host.blocked_hitbox_plus_frames = 0
		
func _enter():
	countering = false
	host.customblock = 0
#	if name == "Treason2":
#		host.blockstun_ticks = 0
	if type == 1 or type == 2 or type == 3:
		if host.Frost < 666:
			host.Frost = min(555,host.Frost + min(10,anim_length/2 + 10))
		else:
			host.Frost += min(10,anim_length/2 + 10)
			
	if name == "Freeze Time":
		host.burst_meter = 0
		host.play_sound("Freeze")
		host.start_invulnerability()
		host.Frost = max(666,host.Frost)
#		host.frostbite = 3
		
	if name == "Landing2":
		host.set_facing(host.get_facing_int()*-1)
	if name == "Wait":
		if not host.is_grounded():
			return "Fall"

func _got_parried():
	._got_parried()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_hurtbox_center()
	var orpos = host.opponent.get_pos()
	var spr_dir = host.get_facing_int()
	
	if host.opponent.blocked_hitbox_plus_frames > host.customblock:
		host.customblock = host.opponent.blocked_hitbox_plus_frames
	else:
		host.opponent.blocked_hitbox_plus_frames = host.customblock 
		
	if host.opponent.current_state().get("perfect") == false:
		host.burst_meter += 50
		host.opponent.burst_meter += 50
		if host.Frost < 666:
			host.Frost = min(555, host.Frost + min(12,current_tick + 6))
		elif host.Frost >= 666:
			host.Frost += min(12,current_tick + 6)
		hitted = 2
		if name == "Serration" or name == "Split":
			host.opponent.apply_force(0,-5)
			host.opponent.move_directly(0,-8)
#		host.opponent.take_damage(round(20 + host.Frost/4),round(20 + host.Frost/4))
		if name == "Warhead" or name == "Serration" or name == "Tyranny" or name == "Breach"  or name == "Invade" or name == "Tyranny2" or name == "Agriculture" or name == "Agriculture2" or name == "Guillotine"  or name == "Domination"  or name == "Shatter" or name == "Shatter2" or editor_description == "ICE":
			if name == "Serration":
				host.opponent.apply_force(0,4)
			host.play_sound("bass5")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TySlashBlockFx.tscn"), Vector2(opos.x - 10*spr_dir,(opos.y + pos.y)/2 - 4), Vector2(host.get_facing_int(), 0))
			if host.frostbite == 3 && host.opponent.current_state().get("push") != true:
				host.Tyarmor = true
				host.customzoom = 25
				host.set_camera_zoom(max(0.65,Global.current_game.camera_zoom/1.15))
				host.tween_camera_zoom(Global.current_game.camera_zoom, Global.current_game.camera_zoom*1.15, 0.5, Tween.TRANS_QUINT, Tween.EASE_IN)
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyFrostFx.tscn"), Vector2(opos.x,host.opponent.get_hurtbox_center_float().y + 6), Vector2(spr_dir,0))
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShardSumFx.tscn"), Vector2(opos.x - 10*spr_dir,(opos.y + pos.y)/2 + 12), Vector2(host.get_facing_int(), 0))
				host.fropos = orpos
				host.frostbite = 6
				host.burst_meter += 100
				host.opponent.burst_meter += 100
				host.opponent.take_damage(host.Frostdamage,host.Frostdamage,"0.25",0,"0.25")
				if host.Frost < 555:
					host.Frost = min(555, host.Frost + 35)
				elif host.Frost >= 666:
					host.Frost += 35
				host.play_sound("frostbite3")
				host.play_sound("Parry")
				host.hitlag_ticks += 4
				host.opponent.hitlag_ticks += 4
			if host.frostbite < 3:
				host.frostbite += 1
			if host.frostbite < 3 && host.winter > 0:
				host.frostbite += 1
		else:
			host.play_sound("bass5")
			if host.winter > 0:
				if host.frostbite == 3 && host.opponent.current_state().get("push") != true:
					host.Tyarmor = true
					host.customzoom = 25
					host.set_camera_zoom(max(0.65,Global.current_game.camera_zoom/1.15))
					host.tween_camera_zoom(Global.current_game.camera_zoom, Global.current_game.camera_zoom*1.15, 0.5, Tween.TRANS_QUINT, Tween.EASE_IN)
					host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyFrostFx.tscn"), Vector2(opos.x,host.opponent.get_hurtbox_center_float().y + 6), Vector2(spr_dir,0))
					host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShardSumFx.tscn"), Vector2(opos.x - 10*spr_dir,(opos.y + pos.y)/2 + 12), Vector2(host.get_facing_int(), 0))
					host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyBlockFx.tscn"), Vector2(opos.x - 10*spr_dir,(opos.y + pos.y)/2 + 12), Vector2(spr_dir,0))
					host.fropos = orpos
					host.frostbite = 6
					host.opponent.take_damage(host.Frostdamage,host.Frostdamage,"0.25",0,"0.25")
					host.burst_meter += 100
					host.opponent.burst_meter += 100
					host.play_sound("frostbite3")
					host.play_sound("Parry")
					host.hitlag_ticks += 4
					host.opponent.hitlag_ticks += 4
					if host.Frost < 555:
						host.Frost = min(555, host.Frost + 35)
					elif host.Frost >= 666:
						host.Frost += 35
			if host.frostbite < 3 && host.winter > 0:
				host.frostbite += 1
		host.play_sound("bass3")
		if name != "Breach" and name != "Invade" and name != "Agriculture2" and name != "Bash" and name != "Warhead":
			iasa_at = current_tick + 4
		if name == "Breach" or name == "Invade":
			iasa_at = 24
		if host.Frost < 555:
			host.Frost = min(555, host.Frost + 15)
		elif host.Frost >= 666:
			host.Frost += 15
	else:
		if name == "Warhead":
			host.hitlag_ticks = 30
			current_tick = 24
	
func update_sprite_frame():
	.update_sprite_frame()
	if name == "Walk5" or name == "Walk4":
		if current_tick < 8:
			host.sprite.animation = host.freezeframe
			host.sprite.frame = host.freezeframef
		else:
			if !host.is_grounded():
				host.sprite.animation = "Jump"
			else:
				host.sprite.animation = "Wait"
				
	if name == "Walk" or name == "Walk2" or name == "Walk3":
		host.sprite.frame = int(host.walkanim/8)%3


func _on_hit_something(_obj, _hitbox):
	._on_hit_something(_obj, _hitbox)
	
	var pos = host.get_pos()
	var opos = host.opponent.get_hurtbox_center()
	var obpos = _obj.get_hurtbox_center()
	var spr_dir = host.get_facing_int()
	if _obj == host.opponent:
		if host.Frost < 666:
			host.Frost = min(555, host.Frost + 4 + round(_hitbox.damage/4))
		elif host.Frost >= 666:
			host.Frost += 4 + round(_hitbox.damage/4)
		if name == "Low Blow" or name == "Treason2":
			host.customzoom = 25
			host.set_camera_zoom(max(0.65,Global.current_game.camera_zoom/1.2))
			host.tween_camera_zoom(Global.current_game.camera_zoom, Global.current_game.camera_zoom*1.2, 0.5, Tween.TRANS_QUINT, Tween.EASE_IN)

		if name == "Hold" && current_tick <= 25:
			host.customzoom = 15
			host.set_camera_zoom(max(0.65,Global.current_game.camera_zoom/1.15))
			host.tween_camera_zoom(Global.current_game.camera_zoom, Global.current_game.camera_zoom*1.15, 0.5, Tween.TRANS_QUINT, Tween.EASE_IN)

		if name == "Back Hand" or name == "Back Hand3" or name == "Backhand2" or name == "Ankle Snap":
			host.customzoom = 10
			host.set_camera_zoom(max(0.65,Global.current_game.camera_zoom/1.2))
			host.tween_camera_zoom(Global.current_game.camera_zoom, Global.current_game.camera_zoom*1.2, 0.5, Tween.TRANS_QUINT, Tween.EASE_IN)
		
		if name == "Crush" or name == "Impose" or name == "Domination":
			host.customzoom = 20
			host.set_camera_zoom(max(0.65,Global.current_game.camera_zoom/1.25))
			host.tween_camera_zoom(Global.current_game.camera_zoom, Global.current_game.camera_zoom*1.25, 0.5, Tween.TRANS_QUINT, Tween.EASE_IN)
		
		if name == "Warhead":
			host.momentum
			host.customzoom = 5
			host.set_camera_zoom(max(0.65,Global.current_game.camera_zoom/1.1))
			host.tween_camera_zoom(Global.current_game.camera_zoom, Global.current_game.camera_zoom*1.1, 1, Tween.TRANS_QUINT, Tween.EASE_IN)
		
		if name == "Agriculture2" or name == "Invade":
			host.customzoom = 6
			host.set_camera_zoom(max(0.45,Global.current_game.camera_zoom/1.15))
			host.tween_camera_zoom(Global.current_game.camera_zoom, Global.current_game.camera_zoom*1.15, 0.5, Tween.TRANS_QUINT, Tween.EASE_IN)
			
	if name == "Serration" or name == "Tyranny" or name == "Breach"  or name == "Invade" or name == "Tyranny2" or name == "Agriculture" or name == "Agriculture2" or name == "Guillotine":
		if _obj == host.opponent:
			if name == "Agriculture2":
				host.opponent.take_damage(10,10,"0.25",0,"0.25")
			if _hitbox.damage > 60:
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TySlashFx.tscn"), Vector2((pos.x + _hitbox.x*spr_dir + obpos.x)/2 + 4*spr_dir,(pos.y + _hitbox.y + obpos.y)/2 - 2), Vector2(spr_dir,0))
			else:
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TySlashFxw.tscn"), Vector2((pos.x + _hitbox.x*spr_dir + obpos.x)/2 + 4*spr_dir,(pos.y + _hitbox.y + obpos.y)/2 - 2), Vector2(spr_dir,0))
		else:
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyBlockFx.tscn"), Vector2((pos.x + _hitbox.x*spr_dir + obpos.x)/2 + 4*spr_dir,(pos.y + _hitbox.y + obpos.y)/2 - 2), Vector2(spr_dir,0))

		
	if _hitbox.damage <= 40 and host.combo_count > 1:
		host.combo_count -= 1
		host.hitstun_decay_combo_count -= 1

	if _obj == host.opponent:
		host.play_sound("bass5")
		host.play_sound("bass3")
		if host.frostbite > 3:
			host.frostbite = 0
		if name == "Back Hand" or name == "Low Blow" or name == "King's Elbow":
			host.play_sound("bass1")
		if name == "Serration" or name == "Tyranny" or name == "Breach"  or name == "Invade" or name == "Tyranny2" or name == "Agriculture" or name == "Agriculture2" or name == "Guillotine":
			host.play_sound("slicebass")
		if name == "Impose":
			host.opponent.take_damage(80,0,"0.25",0,"0.25")
		if name == "Low Blow":
			_obj.move_directly(0, _obj.get_pos().y)
		hitted = 1
		hittick = 1

func _tick():
	
	host.update_grounded()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	var spr_dir = host.get_facing_int()
	var camera = host.get_camera()
	
	if current_tick <= 1:
		realtick = 0
		iasa_at = -1
		hittick = 0
		hitted = 0
		fakehithold = 0
		land_cancel = false
	if name == "Warhead":
		if current_tick == 12:
			if camera && !host.is_ghost:
				camera.bump(Vector2(), 6, 10/ 60.0)
			host.play_sound("phonk2")
		if current_tick == 2:
			if camera && !host.is_ghost:
				camera.bump(Vector2(), 4, 10/ 60.0)
			host.play_sound("scythe")
			host.play_sound("icesum")
		if current_tick < 10:
			host.grab_camera_focus()
			host.start_super(1)
		if current_tick == 15:
			host.release_camera_focus()
			if spr_dir == 1:
				oopos = clamp(opos.x, pos.x + (350 - 240), pos.x + (350 + 140))
			else:
				oopos = clamp(opos.x, pos.x - (350 + 240), pos.x - (350 - 140))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TySlashFx.tscn"), Vector2(oopos,pos.y - 0), Vector2(spr_dir,0))
			host.spawn_object(preload("res://_LamTyrant/characters/TyIcicleD.tscn"), abs(pos.x - oopos) + 20, pos.y * -1)
		if current_tick == 17:
			host.spawn_object(preload("res://_LamTyrant/characters/TyIcicleD.tscn"), abs(pos.x - oopos) + 60, pos.y * -1)
		if current_tick == 16:
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShw1Fx.tscn"), Vector2(oopos,pos.y - 0), Vector2(spr_dir,0))
			host.spawn_object(preload("res://_LamTyrant/characters/TyIcicleD.tscn"), abs(pos.x - oopos) + 40, pos.y * -1)

		if current_tick == 12:
			host.set_vel(8*spr_dir,0)
			host.play_sound("Parry")
			host.play_sound("bass5")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TySlashFxw.tscn"), Vector2(pos.x+6*spr_dir,pos.y - 16), Vector2(spr_dir,0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x+60*spr_dir,pos.y - 16 - 6), Vector2(spr_dir,0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x+110*spr_dir,pos.y - 13 - 6), Vector2(spr_dir,0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x+160*spr_dir,pos.y - 10 - 6), Vector2(spr_dir,0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x+210*spr_dir,pos.y - 9 - 6), Vector2(spr_dir,0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x+260*spr_dir,pos.y - 6 - 6), Vector2(spr_dir,0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x+310*spr_dir,pos.y - 3 - 6), Vector2(spr_dir,0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x+360*spr_dir,pos.y - 0 - 6), Vector2(spr_dir,0))

	if name == "Bash":
		if data == true:
			if int(host.get_vel().y) < 0:
				host.set_vel(int(host.get_vel().x),0)
			host.apply_force(0,8)
			
		if current_tick == 0:
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x,pos.y-20), Vector2(host.get_facing_int(), 0))
			
		if current_tick > 10 && current_tick < 15:
			host.move_directly(8*spr_dir,0)
			host._create_speed_after_image( Color("3ba3ff") ,0.1)
			if hitted > 0:
				host.move_directly((opos.x - pos.x)/2,(opos.y - pos.y)/2)
		if current_tick == 14:
			host.play_sound("bass1")
			host.apply_force(10*spr_dir,0)
		if current_tick == 2:
			host.play_sound("scythe")
			host.play_sound("icesum")
			
		if current_tick == 12:
			host.play_sound("frostbite3")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x + 30*spr_dir,pos.y-20), Vector2(host.get_facing_int(), 0))

		if current_tick == 10:
			host.play_sound("scythe")
			host.play_sound("bass1")
				
		if current_tick == 0:
			host.play_sound("icesum")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x,pos.y-20), Vector2(host.get_facing_int(), 0))

		if current_tick == 2:
			host.play_sound("scythe")
			host.play_sound("bass1")
			
	if name == "Pierce":
		
		if data == true:
			if int(host.get_vel().y) < 0:
				host.set_vel(int(host.get_vel().x),0)
			host.apply_force(0,8)
				
		if current_tick == 0:
			host.play_sound("icesum")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x,pos.y-20), Vector2(host.get_facing_int(), 0))

		if current_tick > 3 && current_tick < 12:
			host.move_directly(6*spr_dir,0)
		if current_tick == 2:
			host.play_sound("scythe")
			host.play_sound("bass1")
			host.apply_force(6*spr_dir,0)
			
	if name == "Shred":
		if hitted == 1 && current_tick > 1 && current_tick < 20:
			host.opponent.move_directly((pos.x - opos.x + (75 - current_tick*2)*spr_dir)/2, (pos.y - 6 - opos.y)/2)

			
		if current_tick == 8:
			host.play_sound("scythe")
			host.apply_force( (4 + int(host.is_grounded())*4)*spr_dir,0)
		
		if current_tick > 6 && current_tick < 16:
			if abs(opos.x - pos.x) > 75:
				if spr_dir == 1 && pos.x < opos.x:
					host.move_directly(10,0)
				if spr_dir == -1 && pos.x > opos.x:
					host.move_directly(-10,0)
					
		if data == true:
			if int(host.get_vel().y) < 0:
				host.set_vel(int(host.get_vel().x),0)
			host.apply_force(0,8)
				
		if current_tick == 0:
			host.play_sound("icesum")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x,pos.y-20), Vector2(host.get_facing_int(), 0))
			
			
		if current_tick == 2:
			host.play_sound("scythe")
			host.play_sound("bass1")
			host.apply_force(6*spr_dir,0)
			
	if name == "Split":
		if current_tick == 0:
			host.statedata = data
			
		if current_tick == 8:
			host.play_sound("scythe")
			host.play_sound("swing2")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
			if host.statedata == false:
				if host.is_grounded():
					host.apply_force(5*spr_dir,-5)
				else:
					host.apply_force(4*spr_dir,-2)
			else:
				if host.is_grounded():
					host.apply_force(3*spr_dir,-9)
				else:
					host.apply_force(1*spr_dir,-4)
				
		if current_tick == 0:
			host.play_sound("icesum")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x,pos.y-20), Vector2(host.get_facing_int(), 0))
			
		if current_tick == 2:
			current_tick += 1
			host.play_sound("bass1")
			host.apply_force(6*spr_dir,0)
			
	if name == "Fast Fall":
		host.move_directly(int(host.get_vel().x), int(host.get_vel().y)/2)
		if int(host.get_vel().y) < 0:
			host.apply_force(0,2)
			
		if current_tick == 0:
			host.apply_force(int(host.get_vel().x)/-2,6)
			
		if current_tick == 4:
			return("Fall")
		
	if name == "Toss":
		host.momentum += 3
		if current_tick == 4:
			var Scythe = host.spawn_object(preload("res://_LamTyrant/characters/TyScytheA.tscn"), 10, -16)
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyBlockFx.tscn"), Vector2(pos.x,pos.y - 16), Vector2(host.get_facing_int(), 0))
			Scythe.set_vel(data.x/10 + 16*spr_dir,data.y/16)
			
	if name == "Recall":
		if current_tick < 4:
			host.start_super(1)
			
	if name == "Toss2":
		host.momentum += 3
		if current_tick == 7:
			host.start_super(4)
			if camera && !host.is_ghost:
				camera.bump(Vector2(), 8, 15/ 60.0)
			host.play_sound("bass2")
			host.play_sound("phonk1")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShw1Fx.tscn"), Vector2(pos.x,pos.y-16), Vector2(host.get_facing_int(), 0))
			var Scythe = host.spawn_object(preload("res://_LamTyrant/characters/TyScytheB.tscn"), 10, -6)
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx1.tscn"), Vector2(pos.x,pos.y - 16), Vector2(host.get_facing_int(), 0))
			Scythe.set_vel(20*spr_dir,0)
			
	if name == "Withdraw":
		if current_tick == 9 && host.combo_count > 0 && host.opponent.current_state().type != 4:
			enable_interrupt()
		host.stancedup = 10
		if current_tick <= 0:
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
			host.play_sound("swing2")
			host.start_throw_invulnerability()
			host.apply_force( (-4 + int(!host.is_grounded())*3)*spr_dir,0)
		else:
			host.set_facing(1 - int(pos.x > opos.x)*2)
			if current_tick % 2 == 0:
				host._create_speed_after_image( Color("3ba3ff") ,0.1)
		if current_tick == 8:
			host.end_throw_invulnerability()
			
	if name != "Hold" or name != "Hold2":
		host.release_opponent()
		
	if name == "Breach" or name == "Invade":
		if hitted == 1 && current_tick > 1 && current_tick < 20:
			host.opponent.move_directly((pos.x - opos.x + (75 - current_tick*2)*spr_dir)/2, (pos.y - 6 - opos.y)/2)
		if current_tick == 2:
			if host.stancedup > 0:
				current_tick += 6
			if name == "Breach" && host.Tyarmor == true && host.initiative:
				host.has_projectile_armor = true
				host.has_hyper_armor = true
			if name == "Invade":
				host.play_sound("scythe")
				current_tick = 11
			
		if current_tick == 23:
			host.has_projectile_armor = false
			host.has_hyper_armor = false
			
		if current_tick == 8:
			host.play_sound("scythe")
		
		if current_tick == 17:
			host.play_sound("scythe")
			host.apply_force( (4 + int(host.is_grounded())*4)*spr_dir,0)
		
		if current_tick > 8 && current_tick < 21:
			if abs(opos.x - pos.x) > 75:
				if spr_dir == 1 && pos.x < opos.x:
					host.move_directly(10,0)
				if spr_dir == -1 && pos.x > opos.x:
					host.move_directly(-10,0)
					
		if current_tick == 0:
			host.play_sound("swing2")
			host.apply_force( (4 + int(host.is_grounded())*4)*spr_dir,0)
			
		if current_tick > 12:
			host.apply_fric()
			
	if name == "Tyranny" or name == "Tyranny2":
		if current_tick == 2 && host.Tyarmor == true && host.initiative:
			host.has_projectile_armor = true
			host.has_hyper_armor = true
			if host.stancedup > 0:
				current_tick += 4
			
		if current_tick == 15:
			host.has_projectile_armor = false
			host.has_hyper_armor = false
			
		if current_tick == 8:
			if host.stancedup > 0:
				current_tick += 2
			host.play_sound("scythe")
			if data == true:
				if int(host.get_vel().y) < 0:
					host.set_vel(int(host.get_vel().x),0)
				host.apply_force(0,8)
			
		if current_tick == 0:
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
			host.play_sound("swing2")
			if data == false:
				host.apply_force((6 + int(host.is_grounded())*6)*spr_dir,0)
			else:
				host.apply_force((2 + int(host.is_grounded())*2)*spr_dir,0)
			
		if current_tick > 12:
			host.apply_fric()
			
	if name == "Agriculture":
		if current_tick == 2:
			if host.stancedup > 0:
				current_tick += 1
			current_tick += 1
			if host.initiative && host.Tyarmor == true:
				host.has_projectile_armor = true
				host.has_hyper_armor = true
		if current_tick == 5:
			if host.stancedup > 0:
				current_tick += 5
			current_tick += 1
			host.play_sound("swing2")
			host.play_sound("scythe")
			
		if current_tick == 15:
			host.has_projectile_armor = false
			host.has_hyper_armor = false
			
			if data == false:
				host.spawn_object(preload("res://_LamTyrant/characters/TyIcicleD.tscn"), 50, pos.y * -1)
			if data == true && hitted > 0 && host.supers_available > 0:
				host.reverse_state = false
				return "Agriculture2"
				
	if name == "Domination":
		if current_tick < 10 && int(host.get_vel().y) < 0:
			host.apply_force(0,4)
		host.apply_force(0,2)
		if current_tick == 7:
			var Scythe = host.spawn_object(preload("res://_LamTyrant/characters/TyScytheC.tscn"), 30, 0)
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x + 36*spr_dir,pos.y), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx2.tscn"), Vector2(pos.x + 36*spr_dir,pos.y), Vector2(host.get_facing_int(), 0))
	
		if current_tick == 2:
			host.hitlag_ticks += 2
#			if host.initiative && host.Tyarmor == true:
#				host.has_projectile_armor = true
#				host.has_hyper_armor = true
			
		if current_tick == 15:
			host.has_projectile_armor = false
			host.has_hyper_armor = false
			
				
		if current_tick == 5:
			host.hitlag_ticks += 2
			host.play_sound("swing2")
			host.play_sound("scythe")
		if current_tick >= 12:
			host.apply_fric()
			if current_tick == 12:
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x + 30*spr_dir,pos.y), Vector2(host.get_facing_int(), 0))
	
	if name == "Agriculture2":
		host.reverse_state = false
		host.start_projectile_invulnerability()
		host.move_directly((opos.x - pos.x - 55*spr_dir)/2, (opos.y - pos.y)/2)
		if current_tick == 1 or current_tick == 5:
			host.start_super(1)
		if current_tick == 0:
			host.supers_available -= 1
			host.storedmeter += 35
#			if host.supers_available % 2 == 0:
#				anim_name = "Agriculture2"
#			else:
#				anim_name = "Agriculture3"
				
		if current_tick == 10:
			if hitted == 2:
				enable_interrupt()
			elif host.supers_available > 0:
				return "Agriculture2"
				
		if current_tick == 2:
			host.play_sound("swing2")
			host.play_sound("scythe")
			
		if current_tick == 22:
			enable_interrupt()
			
	if name == "Guillotine":
		host.apply_fric()
		
		if current_tick == 0:
			if data == true:
				if int(host.get_vel().y) < 0:
					host.set_vel(int(host.get_vel().x),0)
				host.apply_force(0,4)
				
		if current_tick == 2:
			if host.stancedup > 0:
				current_tick += 6
			if host.initiative && host.Tyarmor == true:
				host.has_projectile_armor = true
				host.has_hyper_armor = true
			host.play_sound("scythe")
			host.play_sound("swing2")
			
		if current_tick == 11:
			host.has_projectile_armor = false
			host.has_hyper_armor = false
			land_cancel = true
			
			
	if name == "Serration":
		if current_tick == 0:
			host.statedata = data
		if current_tick == 2 && host.Tyarmor == true:
			host.has_projectile_armor = true
			host.has_hyper_armor = true
			if host.stancedup > 0:
				current_tick += 4
			
		if current_tick == 15:
			host.has_projectile_armor = false
			host.has_hyper_armor = false
			
		if current_tick > 12:
			host.apply_fric()
			
		if current_tick == 8:
			if host.stancedup > 0:
				current_tick += 2
			host.play_sound("scythe")
			host.play_sound("swing2")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
			if host.statedata == false:
				if host.is_grounded():
					host.apply_force(9*spr_dir,-5)
				else:
					host.apply_force(5*spr_dir,-2)
			else:
				if host.is_grounded():
					host.apply_force(4*spr_dir,-9)
				else:
					host.apply_force(2*spr_dir,-4)
					
	if name == "Cataclysm":
		if current_tick == 2:
			host.start_super(2)
			host.storedmeter += 45
			current_tick += 3
#			if host.initiative && host.Tyarmor == true:
#				host.has_projectile_armor = true
#				host.has_hyper_armor = true
			
#		if current_tick == 16:
#			host.has_projectile_armor = false
#			host.has_hyper_armor = false
		
		if current_tick == 9 && host.is_grounded():
			host.spawn_object(preload("res://_LamTyrant/characters/TyIcicle.tscn"), max(80,abs(opos.x - pos.x)) + 45, pos.y * -1)
#		if current_tick == 10 && host.is_grounded():
#			host.spawn_object(preload("res://_LamTyrant/characters/TyIcicle.tscn"), -80, pos.y * -1)
		if current_tick == 12:
			if camera && !host.is_ghost:
				camera.bump(Vector2(), 8, 15/ 60.0)
			host.play_sound("bass2")
			host.play_sound("phonk1")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShw1Fx.tscn"), Vector2(pos.x,pos.y-16), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShardSumFx.tscn"), Vector2(pos.x,pos.y-16), Vector2(host.get_facing_int(), 0))
			host.start_super(4)
			
		if !host.is_grounded():
			
			host.apply_force(0,1)
			
			if current_tick > 8:
				if host.opponent.current_state().current_tick > 0 && host.opponent.current_state().type != 4:
					for objs in host.objs_map.values():
						if is_instance_valid(objs):
							if !objs.is_in_group("Fighter"):
								objs.hitlag_ticks = 2
					host.opponent.hitlag_ticks = 2
					
				host.apply_fric()
				host.move_directly(0,15)
				current_tick -= 1
				
		
	if name == "Impose":
		if current_tick == 0:
			throw_techable = true
			
		if current_tick == 16:
			throw_techable = false
		
		

	if name == "Terrorize":
		host.momentum = 0
		host.colliding_with_opponent = false
		if current_tick == 0:
			host.storedmeter += 65
#			if host.combo_count > 0:
#				host.opponent.hitlag_ticks = 5
#			if camera && !host.is_ghost:
#				camera.bump(Vector2(), 6, 6/ 60.0)
			host.play_sound("bass3")
			host.play_sound("phonk2")
			
		if current_tick == 4:
			if host.frostbite < 3:
				host.frostbite += 1
				if host.winter > 0:
					host.frostbite = 3
#			host.spawn_object(preload("res://_LamTyrant/characters/TyIcicle.tscn"), 0, pos.y * -1)
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShw1Fx.tscn"), Vector2(pos.x,pos.y-16), Vector2(host.get_facing_int(), 0))
			if camera && !host.is_ghost:
				camera.bump(Vector2(), 10, 10 / 60.0)
			host.play_sound("phonk1")
			host.play_sound("bass2")
		if current_tick >= 4:
#			if host.initiative:
#				host.has_projectile_armor = true
#				host.has_hyper_armor = true
			host.set_vel(2*spr_dir, 0)
			
			if current_tick >= 8:
				host.opponent.hitlag_ticks = 2
				for objs in host.objs_map.values():
					if is_instance_valid(objs):
						if !objs.is_in_group("Fighter"):
							objs.hitlag_ticks = 2
				
			if abs(opos.x - (pos.x - 60*spr_dir)) > 20:
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x,pos.y-20), Vector2(host.get_facing_int(), 0))
				host.move_directly((opos.x - pos.x)/10,0)
				host.move_directly(10*spr_dir,0)
		else:
			host.start_super(1)
			
	if name == "Walk4" or name == "Walk5":
		host.set_facing(host.freezeframed)
		if current_tick == 4 && host.combo_count > 0 && host.opponent.current_state().type != 4:
			enable_interrupt()
	if name == "Walk2" or name == "Walk4":
		if host.opponent.current_state().type == 4 && !host.opponent.current_state().get("IS_NEW_PARRY"):
			anim_length = 18
		else:
			anim_length = 12
			
		if current_tick == 0:
			if name == "Walk4":
				host.storedmeter += 25
			var cicle = host.spawn_object(preload("res://_LamTyrant/characters/TyIcicleD.tscn"), data.x*5 - 120, pos.y * -1)
			cicle.hitlag_ticks = max(0,(data.x - 30)/10)
			
	if name == "Walk3" or name == "Walk5":
		if current_tick == 0:
			if name == "Walk5":
				host.storedmeter += 25
			var shardB = host.spawn_object(preload("res://_LamTyrant/characters/TyShardB.tscn"), data.x*5 - 120, pos.y * -1)
			shardB.set_vel(0,-4 - data.x/20)
		
	if name == "Walk" or name == "Walk2" or name == "Walk3":
		if host.is_grounded():
			host.momentum += 3
		else:
			host.apply_fric()
			if int(host.get_vel().x)*spr_dir < 0:
				host.apply_force(1*spr_dir,0) 
			host.skatetime -= 1
			if host.skatetime <= 0 or name != "Walk":
				if name == "Walk2":
					return "Fall2"
				return "Fall"
			else:
				if host.skatetime % 4 == 0:
					host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TySkateFx.tscn"), Vector2(pos.x,pos.y+4), Vector2(host.get_facing_int(), 0))
				if pos.y < -20:
					if int(host.get_vel().y) > 1 && current_tick % 2 == 0:
						host.apply_force(0,-1)
					if int(host.get_vel().y) > 0:
						host.apply_force(0,-1)
		host.walkanim += 1
		
		if host.walkanim % (8*3) == 8:
			if host.is_grounded():
				host.play_sound("step")
			else:
				host.play_sound("skate")
				
		if current_tick == 0 or current_tick == 4:
			host.apply_force((1 + int(host.is_grounded()))*spr_dir,0)
			
	if name == "Landing2":
		host.colliding_with_opponent = false
		if current_tick == 0:
			host.start_super(4)
			
	if name == "King's Elbow":
		host.colliding_with_opponent = false
		if current_tick == 0:
			host.apply_force(data.x/15*spr_dir,-2)
			host.play_sound("swing2")
			
		if current_tick < 3:
			host.start_super(1)
			
		if current_tick == 8:
			host.set_vel(0,10)
			host.play_sound("swing1")
		if current_tick > 9:
			if hitted == 1:
				host.opponent.hitlag_ticks = 2
				host.opponent.move_directly(0, (pos.y + 10 - opos.y))
				
			if host.opponent.current_state().current_tick > 0 && host.opponent.current_state().type != 4:
				for objs in host.objs_map.values():
					if is_instance_valid(objs):
						if !objs.is_in_group("Fighter"):
							objs.hitlag_ticks = 2
				host.opponent.hitlag_ticks = 2
			host.apply_fric()
			host.move_directly(0,15)
			current_tick -= 1
			if host.is_grounded():
				if camera && !host.is_ghost:
					camera.bump(Vector2(), 8, 10 / 60.0)
				host.play_sound("phonk1")
				return "Landing2"
			
	if name == "Kick":
		if current_tick == 0:
			if data == true:
				if int(host.get_vel().y) < 0:
					host.set_vel(int(host.get_vel().x),0)
				host.apply_force(0,4)
				
		if current_tick > 6:
			land_cancel = true
			
			
	if name == "Low Blow":
		if host.combo_count <= 0:
			if current_tick == 0:
				host.thronepos = opos
			if current_tick > 4 && current_tick < 16:
				if current_tick %2 == 0 && host.opponent.current_state().type != 4:
					host.opponent.hitlag_ticks = 1
					for objs in host.objs_map.values():
						if is_instance_valid(objs):
							if !objs.is_in_group("Fighter"):
								objs.hitlag_ticks += 1
				if (host.thronepos.x < opos.x - 10) && spr_dir == 1:
					host.move_directly(8,0)
					host.apply_force(2,0)
				if (host.thronepos.x > opos.x + 10) && spr_dir == -1:
					host.move_directly(-8,0)
					host.apply_force(-2,0)
		if current_tick < 4 && abs(pos.x - opos.x) < 80:
			host.apply_force(-1*spr_dir,0)
			host.move_directly(-4*spr_dir,0)
		if current_tick == 5:
			host.play_sound("bass3")
			host.set_vel(12*spr_dir,0)
		if current_tick == 0 or current_tick == 3 or current_tick == 7:
			current_tick += 1
			host.start_super(1)
			
	if name == "Ankle Snap":
		if current_tick == 1:
			host.start_super(1)
			
	if name == "Back Hand" or name == "Back Hand2":
		if current_tick == 0 or current_tick == 1:
			host.start_super(1)
			
	if name == "Roundcastle":

		if current_tick > 9:
			land_cancel = true
			
		if current_tick == 1 or current_tick == 3:
			host.start_super(1)
			
		if current_tick == 1:
#			host.start_projectile_invulnerability()
			if host.is_grounded():
#				if opos.y < pos.y && host.initiative:
#					host.start_invulnerability()
				host.apply_force(2*spr_dir,-7)
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
			host.move_directly(data.x/14,data.y/10)
			host.apply_force(data.x/12 + 2*spr_dir,data.y/8 + 5)
			
		if current_tick > 6:
			host.apply_fric()
			if current_tick < 12:
				host.apply_grav()
			else:
				host.end_invulnerability()
				if int(host.get_vel().y) < -4:
					 host.apply_force(0,1)
	if name == "Strong Punch":
		if !host.is_grounded():
			host.apply_fric()
		if current_tick == 9:
			current_tick += 1
#		if data.x <= 50 && current_tick == 7:
#			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyFrostFx.tscn"), Vector2(pos.x + 10*spr_dir,pos.y-20), Vector2(host.get_facing_int(), 0))
#			var shard = host.spawn_object(preload("res://_LamTyrant/characters/TyShardA.tscn"), 10, -20)
#			shard.set_vel( 6*spr_dir + data.x/3*spr_dir, -10 + data.x/5 + (4 - int(!host.is_grounded())*4))
#			host.play_sound("frostbite4")
		if current_tick == 1 or current_tick == 2:
			host.start_super(1)
		if current_tick == 0:
			host.start_super(1)
			host.apply_force((data.x/10*spr_dir + (4 - int(!host.is_grounded())*4)*spr_dir),data.x/12)
			
	if name == "Hold2":
		if (host.extratech > 0 or host.weakergrab > 0) && current_tick == 8:
			return "Back Hand3"
		host.opponent.hitlag_ticks = 12
		host.opponent.move_directly((pos.x - opos.x + (64 - current_tick*2)*spr_dir)/2, (pos.y - 6 - opos.y)/2)
	if name == "Back Hand3":
		if current_tick < 4:
			host.opponent.set_pos(pos.x + 24*spr_dir, pos.y - 6 )
	if name == "Hold":
		if (host.extratech > 0 or host.weakergrab > 0) && current_tick > 6:
			return "Back Hand3"
		if current_tick == 0:
			host.start_super(2)
		host.start_invulnerability()
		host.colliding_with_opponent = false
		if current_tick < 4:
			if host.extratech <= 0:
				host.opponent.move_directly((pos.x - opos.x + (14)*spr_dir)/2, (pos.y - 16 - opos.y)/2)
			else:
				host.opponent.move_directly((pos.x - opos.x + (24)*spr_dir)/2, (pos.y - 6 - opos.y)/2)
		elif current_tick < 24:
			oldpos = pos
			if host.extratech <= 0:
				host.opponent.hitlag_ticks = 2
				host.opponent.move_directly((pos.x - opos.x - (4)*spr_dir)/3, (pos.y - 40 - opos.y)/2)
			else:
				host.opponent.move_directly((pos.x - opos.x + (24)*spr_dir)/2, (pos.y - 6 - opos.y)/2)
		elif current_tick < 34:
			host.set_vel(12*spr_dir,0)
			host.opponent.set_vel(12*spr_dir,0)
			host.opponent.set_pos(pos.x + 4*spr_dir,6)
		elif current_tick < 46:
			host.set_vel(8*spr_dir,0)
		if current_tick == 4 && host.extratech <= 0 :
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))

			host.release_opponent()
			if camera && !host.is_ghost:
				camera.bump(Vector2(), 8, 10 / 60.0)
			host.play_sound("phonk1")
			host.play_sound("swing2")
			host.set_vel(6*spr_dir,-12)
		if current_tick == 25:
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShw1Fx.tscn"), Vector2(pos.x,pos.y-16), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x,pos.y-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((oldpos.x + pos.x)/2,(oldpos.y + pos.y)/2-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((oldpos.x*2 + pos.x)/3,(oldpos.y*2 + pos.y)/3-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((oldpos.x*3 + pos.x)/4,(oldpos.y*3 + pos.y)/4-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((oldpos.x + pos.x*2)/3,(oldpos.y + pos.y*2)/3-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((oldpos.x + pos.x*3)/4,(oldpos.y + pos.y*3)/4-20), Vector2(host.get_facing_int(), 0))
		if current_tick == 24:
			host.play_sound("bass2")
			if camera && !host.is_ghost:
				camera.bump(Vector2(), 8, 20 / 60.0)
			host.play_sound("phonk2")
			host.set_vel(12*spr_dir,5)
			host.set_pos(pos.x + 40*spr_dir - pos.y/2*spr_dir,0)
			
	if name == "Isolate" or name == "Isolate2":
		if current_tick == 0:
			host.Frost = 666
#			host.frostbite = 3
			
	if name == "Shatter" or name == "Shatter2":
		host.colliding_with_opponent = false
		if current_tick < 7:
			host.global_hitlag(1,true)
		if hitted > 0:
			host.start_super(3)
			if hitted == 2:
				host.opponent.set_vel(2*spr_dir,-2)
			if current_tick <= 16:
				host.opponent.set_pos(pos.x + 14*spr_dir,-8)
		if current_tick == 2:
			host.storedmeter += 45
			host.start_super(1)
			current_tick += 1
		if current_tick == 5:
			host.start_projectile_invulnerability()
			host.start_super(1)
			current_tick += 1
				
	if name == "Conquer" or name == "Conquer2":
		if data.Shard == false:
			if data.Delay == true:
				if current_tick == 2:
					host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShw1Fx.tscn"), Vector2(pos.x,pos.y-16), Vector2(host.get_facing_int(), 0))
					host.start_super(2)
					current_tick += 4
					host.spawn_object(preload("res://_LamTyrant/characters/TyIcicleD.tscn"), 80, pos.y * -1)
				if current_tick == 8:
					host.start_super(2)
					current_tick += 4
					host.spawn_object(preload("res://_LamTyrant/characters/TyIcicleD.tscn"), 180, pos.y * -1)
				if current_tick == 14:
					host.start_super(2)
					host.spawn_object(preload("res://_LamTyrant/characters/TyIcicleD.tscn"), 280, pos.y * -1)
					
			else:
				if current_tick == 4:
					host.spawn_object(preload("res://_LamTyrant/characters/TyIcicle.tscn"), 80, pos.y * -1)
				if current_tick == 8:
					host.spawn_object(preload("res://_LamTyrant/characters/TyIcicle.tscn"), 180, pos.y * -1)
				if current_tick == 12:
					host.spawn_object(preload("res://_LamTyrant/characters/TyIcicle.tscn"), 280, pos.y * -1)
					
		else:
#			if data.Delay == true:
			if current_tick == 2:
				host.supers_available -= 1
#				host.storedmeter += 65
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShw1Fx.tscn"), Vector2(pos.x,pos.y-16), Vector2(host.get_facing_int(), 0))
				host.start_super(2)
				current_tick += 2
				var shardB = host.spawn_object(preload("res://_LamTyrant/characters/TyShardB.tscn"), 80, pos.y * -1)
				shardB.set_vel(0,-6 - current_tick/2)
			if current_tick == 8:
				host.start_super(2)
				current_tick += 2
				var shardB = host.spawn_object(preload("res://_LamTyrant/characters/TyShardB.tscn"), 180, pos.y * -1)
				shardB.set_vel(0,-6 - current_tick/2)
			if current_tick == 14:
				host.start_super(2)
				var shardB = host.spawn_object(preload("res://_LamTyrant/characters/TyShardB.tscn"), 280, pos.y * -1)
				shardB.set_vel(0,-6 - current_tick/2)
#			else:
#				if current_tick > 0 && current_tick % 4 == 0:
#					var shardA = host.spawn_object(preload("res://_LamTyrant/characters/TyShardA.tscn"), 5 + current_tick*16, pos.y * -1)
#					shardA.set_vel(2*spr_dir ,-14 )
					
	
	if name == "Taunt":
		realtick += 1
		if host.combo_count > 0:
			host.feinting = true
		if current_tick == 19 && host.combo_count <= 0:
			host.state_interruptable = true
		if realtick == 59:
			if camera && !host.is_ghost:
				camera.bump(Vector2(), 6, 15/ 60.0)
			host.play_sound("bass2")
			host.play_sound("phonk1")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShw1Fx.tscn"), Vector2(pos.x,pos.y-16), Vector2(host.get_facing_int(), 0))
			host.Frost += 125
			host.frostbite = 3
			realtick = 0
		if current_tick == 39 && host.combo_count <= 0:
			host.state_interruptable = true
		if current_tick > 41:
			current_tick = 22
		if current_tick == 9:
			host.spawn_object(preload("res://_LamTyrant/characters/TyIcicle.tscn"), 0, pos.y * -1)
		if current_tick < 9:
			host.thronepos = pos
		else:
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TySitFx.tscn"), Vector2(pos.x,pos.y - 6), Vector2(host.get_facing_int(), 0))
			if current_tick % 10 == 0:
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
			host.storedmeter += 3
			host.set_pos(int(host.thronepos.x),int(host.thronepos.y))
			
	if name == "Treason":
		if host.opponent.get("charname") == "Big Sword":
			return "Wait"
		if countering == true && current_tick >= 2:
			host.start_invulnerability()
		if ((host.initiative)) && host.opponent.current_state().name != "Treason":
			if (current_tick == 0 && host.initiative) or current_tick >= 2:
				host.start_invulnerability()
			if host.opponent.current_state().name != "Getup" && (host.opponent.invulnerable == true or host.opponent.has_hyper_armor == true):
				countering = true
				
			var opp_hitboxes = host.opponent.get_active_hitboxes()
			for hitbox in opp_hitboxes:
				if  (hitbox.overlaps(host.hurtbox)):
					if (hitbox.ignore_armor == true or hitbox.guard_break == true or hitbox.throw == true or countering == true) and hitbox.hitbox_type != 4:
						countering = true
						hitbox.deactivate()
						if host.opponent.hitlag_ticks <= 0:
							host.opponent.hitlag_ticks = 20
							host.start_super(8)
							if camera && !host.is_ghost:
								camera.bump(Vector2(), 8, 12 / 60.0)
						host.play_sound("Block2")
						host.play_sound("Parry")
						host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyBlockFx.tscn"), Vector2(pos.x,pos.y-16), Vector2(host.get_facing_int(), 0))
					else:
						host.end_invulnerability()
						return "WaitH"
			
			if current_tick > 12 && countering == true:
				return "Treason2"
			 
		if current_tick >= 8 && countering == true:
			host.opponent.hitlag_ticks = 2
			
		if current_tick == 0 or current_tick == 4 or current_tick == 8:
			host.play_sound("skate2")
	
	if name == "Treason2":
		host.start_invulnerability()
		host.colliding_with_opponent = false
		if current_tick <= 1:
			host.opponent.change_state("Wait")
		if current_tick == 0:
			oldpos = pos
			host.Frost += 35
		if current_tick == 1:
			host.set_pos(opos.x,opos.y)
			if !host.is_grounded():
				host.set_vel(5*spr_dir,-3)
			else:
				host.set_vel(8*spr_dir,0)
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShw1Fx.tscn"), Vector2(pos.x,pos.y-16), Vector2(host.get_facing_int(), 0))

			host.release_opponent()
			if camera && !host.is_ghost:
				camera.bump(Vector2(), 8, 10 / 60.0)
			host.play_sound("phonk1")
			host.play_sound("swing2")
			
		if current_tick == 2:
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x,pos.y-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((oldpos.x + pos.x)/2,(oldpos.y + pos.y)/2-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((oldpos.x*2 + pos.x)/3,(oldpos.y*2 + pos.y)/3-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((oldpos.x*3 + pos.x)/4,(oldpos.y*3 + pos.y)/4-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((oldpos.x + pos.x*2)/3,(oldpos.y + pos.y*2)/3-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((oldpos.x + pos.x*3)/4,(oldpos.y + pos.y*3)/4-20), Vector2(host.get_facing_int(), 0))
