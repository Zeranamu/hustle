extends ObjectState

var hitted = 0

func _got_parried():
	._got_parried()
	var pos = host.get_pos()
	var opos = host.creator.opponent.get_hurtbox_center()
	var orpos = host.creator.opponent.get_pos()
	var spr_dir = host.get_facing_int()
	host.creator.burst_meter += 25
	host.creator.opponent.burst_meter += 25
	if host.creator.opponent.blocked_hitbox_plus_frames > host.creator.customblock:
		host.creator.customblock = host.creator.opponent.blocked_hitbox_plus_frames
	else:
		host.creator.opponent.blocked_hitbox_plus_frames = host.creator.customblock 
		
	host.creator.global_hitlag(2,true)
	
	if name == "Scythe":
		host.creator.opponent.gain_super_meter(20)
		if current_tick < 60:
			current_tick += 70
			if host.creator.opponent.current_state().perfect == false:
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyBlockFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
				host.creator.play_sound("slicebass")
				var ShardC = host.spawn_object(load("res://_LamTyrant/characters/TyShardB.tscn"), 0, 10)
				ShardC.creator = host.creator
				ShardC.creator_name = host.creator.name
				ShardC.set_vel((4-abs(pos.x%8))*spr_dir,-9)
				host.has_projectile_parry_window = true
				host.set_vel(0,-2)
			else:
				host.has_projectile_parry_window = true
				host.set_vel(0,-2)
	if name == "Scythe2":
		host.creator.opponent.gain_super_meter(20)
		if current_tick < 40:
			current_tick += 10
			if host.creator.opponent.current_state().perfect == false:
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyBlockFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
				host.creator.play_sound("slicebass")
				var ShardC = host.spawn_object(load("res://_LamTyrant/characters/TyShardC.tscn"), 0, 10)
				ShardC.creator = host.creator
				ShardC.creator_name = host.creator.name
				ShardC.set_vel((4-abs(pos.x%8))*spr_dir,-9)
			else:
				current_tick += 40
				host.has_projectile_parry_window = true
	if name == "ShardC":
		fizzle()
		
	if host.creator.current_state().get("perfect") != null:
			host.creator.play_sound("bass5")
			host.creator.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TySlashBlockFx.tscn"), Vector2(opos.x - 10*spr_dir,(opos.y + pos.y)/2 - 4), Vector2(host.get_facing_int(), 0))
	else:
		if host.creator.opponent.current_state().get("perfect") == false:
				host.creator.play_sound("bass5")
				host.creator.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TySlashBlockFx.tscn"), Vector2(opos.x - 10*spr_dir,(opos.y + pos.y)/2 - 4), Vector2(host.get_facing_int(), 0))
				if host.creator.frostbite < 3:
					host.creator.frostbite += 1

			
func _on_hit_something(_obj, _hitbox):
	._on_hit_something(_obj, _hitbox)
	var pos = host.get_pos()
	var opos = _obj.get_hurtbox_center()
	var spr_dir = host.get_facing_int()
	
	for objs in host.objs_map.values():
		if is_instance_valid(objs):
			if !objs.is_in_group("Fighter"):
				objs.hitlag_ticks = 4
			
	
	if _obj == host.creator.opponent:
		hitted = 1
		if _hitbox.hitbox_type == 5:
			if host.creator.combo_count > 0:
				host.creator.visible_combo_count += 1
			if _obj.hitlag_ticks <= 12:
				_obj.hitlag_ticks = min(12, _obj.hitlag_ticks + 6)
		host.creator.global_hitlag(4,true)
		if name == "Idle":
			if host.creator.current_state().type != 0 && host.creator.current_state().type != 4:
				host.creator.current_state().iasa_at = max( 18, host.creator.current_state().current_tick + 6)
		
	if name == "Scythe" or name == "Scythe2":
		_hitbox.group += 1
		

func _tick():
	var pos = host.get_pos()
	var cpos = host.creator.get_pos()
	var opos = host.creator.opponent.get_pos()
	var spr_dir = host.get_facing_int()
	var cstate = host.creator.current_state()
	var camera = host.creator.get_camera()
	if name == "Scythe4":
		if host.creator.current_state().name == "ParrySuper":
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx1.tscn"), Vector2(cpos.x,host.creator.get_hurtbox_center_float().y), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x,pos.y-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x + pos.x)/2,(cpos.y + pos.y)/2-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x*2 + pos.x)/3,(cpos.y*2 + pos.y)/3-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x*3 + pos.x)/4,(cpos.y*3 + pos.y)/4-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x + pos.x*2)/3,(cpos.y + pos.y*2)/3-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x + pos.x*3)/4,(cpos.y + pos.y*3)/4-20), Vector2(host.get_facing_int(), 0))
			fizzle()
			
		if host.creator.current_state().name == "Domination" && host.creator.current_state().current_tick == 2:
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx1.tscn"), Vector2(cpos.x,host.creator.get_hurtbox_center_float().y), Vector2(host.get_facing_int(), 0))
			fizzle()
			
		if host.creator.current_state().name == "Hold":
			if host.creator.current_state().current_tick < 5:
				if pos.x < cpos.x:
					host.creator.set_facing(-1)
				else:
					host.creator.set_facing(1)
					
			if host.creator.current_state().current_tick >= 25:
				var ScytheA = host.spawn_object(load("res://_LamTyrant/characters/TyScytheA.tscn"), 0, -10)
				ScytheA.creator = host.creator
				ScytheA.creator_name = host.creator.name
				ScytheA.set_vel(0,-6)
				fizzle()
				
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyBlockFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
				
				var ShardA = host.spawn_object(load("res://_LamTyrant/characters/TyShardC.tscn"), 0, 10)
				ShardA.creator = host.creator
				ShardA.creator_name = host.creator.name
				ShardA.set_vel(-4,-10)
				
				var ShardB = host.spawn_object(load("res://_LamTyrant/characters/TyShardC.tscn"), 0, 10)
				ShardB.creator = host.creator
				ShardB.creator_name = host.creator.name
				ShardB.set_vel(4,-10)
				
			
		if current_tick == 0:
			host.cooldown1 = 1
			host.cooldown2 = 3
		else:
			host.cooldown1 -= 1
			host.cooldown2 -= 1
		host.creator.hasscythevisual = false
		host.creator.hasscythe = false
		if host.creator.super_meter < 0:
			host.creator.supers_available -= 1
			host.creator.super_meter += 125
#		if host.creator.supers_available > 0 or host.creator.super_meter > 25:
		if host.creator.hitlag_ticks == 0 && ((host.creator.current_state().name == "Domination" && host.creator.current_state().current_tick == 10) or (host.creator.current_state().name == "Cataclysm" && host.creator.current_state().current_tick == 11) or (host.creator.current_state().name == "Crush" && host.creator.current_state().current_tick == 11) or (host.creator.current_state().name == "Shatter" && host.creator.current_state().current_tick == 7)):
			if host.cooldown1 <= 0:
				host.cooldown1 = 10
				host.screen_bump(Vector2(), 10, Utils.frames(10))
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TySlashBlockFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
#				host.creator.super_meter -= 25
				host.creator.play_sound("bass2")
				host.creator.play_sound("bass1")
				var ShardA = host.spawn_object(load("res://_LamTyrant/characters/TyShardD.tscn"), 0, 0)
				ShardA.creator = host.creator
				ShardA.creator_name = host.creator.name
				ShardA.set_vel(-20,0)
				var ShardB = host.spawn_object(load("res://_LamTyrant/characters/TyShardD.tscn"), 0, 0)
				ShardB.creator = host.creator
				ShardB.creator_name = host.creator.name
				ShardB.set_vel(20,0)
#		if host.creator.supers_available > 0 or host.creator.super_meter > 45:
		if host.creator.hitlag_ticks == 0 && ((host.creator.current_state().name == "Domination" && host.creator.current_state().current_tick == 10) or (host.creator.current_state().name == "Cataclysm" && host.creator.current_state().current_tick == 11) or (host.creator.current_state().name == "Terrorize" && host.creator.current_state().current_tick == 6) or (host.creator.current_state().name == "Walk4" && host.creator.current_state().current_tick == 1) or (host.creator.current_state().name == "Walk3" && host.creator.current_state().current_tick == 1) or (host.creator.current_state().name == "Walk2" && host.creator.current_state().current_tick == 1) or (host.creator.current_state().name == "Shatter" && host.creator.current_state().current_tick == 7)):
			if host.cooldown2 <= 0:
				host.cooldown2 = 2
#				host.creator.super_meter -= 45
				
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyBlockFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
				host.creator.play_sound("slicebass")
				var ShardC = host.spawn_object(load("res://_LamTyrant/characters/TyShardB.tscn"), 0, 10)
				ShardC.creator = host.creator
				ShardC.creator_name = host.creator.name
				ShardC.set_vel((4-abs(pos.x%8))*spr_dir,-9)
				
		if current_tick % 12 == 0 && !host.is_ghost:
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
		
#		if host.creator.opponent.combo_count > 0:
#			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx1.tscn"), Vector2(cpos.x,host.creator.get_hurtbox_center_float().y), Vector2(host.get_facing_int(), 0))
#			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x,pos.y-20), Vector2(host.get_facing_int(), 0))
#			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x + pos.x)/2,(cpos.y + pos.y)/2-20), Vector2(host.get_facing_int(), 0))
#			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x*2 + pos.x)/3,(cpos.y*2 + pos.y)/3-20), Vector2(host.get_facing_int(), 0))
#			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x*3 + pos.x)/4,(cpos.y*3 + pos.y)/4-20), Vector2(host.get_facing_int(), 0))
#			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x + pos.x*2)/3,(cpos.y + pos.y*2)/3-20), Vector2(host.get_facing_int(), 0))
#			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x + pos.x*3)/4,(cpos.y + pos.y*3)/4-20), Vector2(host.get_facing_int(), 0))
#			fizzle()
			
		if host.creator.current_state().name == "Recall" or host.creator.opponent.hp <= 0 or current_tick > 300 or host.creator.opponent.combo_count > 0 :
			if host.creator.current_state().current_tick < 6:
				pass
			else:
				if host.creator.current_state().current_tick >= 6:
					host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx1.tscn"), Vector2(pos.x,pos.y - 10), Vector2(host.get_facing_int(), 0))
				var ScytheA = host.spawn_object(load("res://_LamTyrant/characters/TyScytheA.tscn"), 0, -10)
				ScytheA.creator = host.creator
				ScytheA.creator_name = host.creator.name
				fizzle()
	
	if name == "Scythe2":
		host.apply_force(0,6)
		if current_tick % 5 == 0 && !host.is_ghost:
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
			
#		if host.is_grounded() && (current_tick == 6 or current_tick == 16 or current_tick == 26):
#			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyBlockFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
#			host.creator.play_sound("slicebass")
#			var ShardB = host.spawn_object(load("res://_LamTyrant/characters/TyIcicleD.tscn"), 0, 10)
#			ShardB.creator = host.creator
#			ShardB.creator_name = host.creator.name
##			ShardB.set_vel(4*spr_dir,-10)
			
		if current_tick > 36:
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx1.tscn"), Vector2(pos.x,pos.y - 16), Vector2(host.get_facing_int(), 0))
			host.creator.play_sound("phonk2")
			host.creator.play_sound("scythe")
			var ScytheA = host.spawn_object(load("res://_LamTyrant/characters/TyScytheA.tscn"), 0, 0)
			ScytheA.creator = host.creator
			ScytheA.creator_name = host.creator.name
			ScytheA.set_vel(2*spr_dir,-8)
			fizzle()
			
	if name == "Scythe" or name == "Scythe2":
		if current_tick < 8 && name == "Scythe" && host.creator.current_state().name == "Toss":
			host.has_projectile_parry_window = true
			host.always_parriable = true
		if current_tick == 8:
			host.has_projectile_parry_window = false
			host.always_parriable = false
		if current_tick > 8 && host.has_projectile_parry_window == true:
			host.can_be_hit_by_melee = false
			anim_name = "Scythe3"
			for my_hitbox in host.get_active_hitboxes():
				my_hitbox.hits_vs_grounded = false
				my_hitbox.hits_vs_aerial = false
				my_hitbox.hits_vs_standing = false
				
		host.set_facing(1 - int(int(host.get_vel().x) < 0)*2)
		host.creator.hasscythevisual = false
		if host.creator.current_state().name == "ParrySuper":
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx1.tscn"), Vector2(cpos.x,host.creator.get_hurtbox_center_float().y), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x,pos.y-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x + pos.x)/2,(cpos.y + pos.y)/2-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x*2 + pos.x)/3,(cpos.y*2 + pos.y)/3-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x*3 + pos.x)/4,(cpos.y*3 + pos.y)/4-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x + pos.x*2)/3,(cpos.y + pos.y*2)/3-20), Vector2(host.get_facing_int(), 0))
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2((cpos.x + pos.x*3)/4,(cpos.y + pos.y*3)/4-20), Vector2(host.get_facing_int(), 0))
			fizzle()
			
		if (host.creator.current_state().name == "Toss" && host.creator.current_state().current_tick <= 2) or host.creator.current_state().name == "Withdraw" or (host.creator.current_state().name != "Walk2" && host.creator.current_state().name != "Walk3" && host.creator.current_state().type == 2 && host.creator.current_state().editor_description != "ICE"):
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx1.tscn"), Vector2(cpos.x,host.creator.get_hurtbox_center_float().y), Vector2(host.get_facing_int(), 0))
			fizzle()
			
		if abs(pos.x - cpos.x) > 90 or abs(pos.y - host.creator.get_hurtbox_center_float().y) > 90:
			host.creator.hasscythe = false
		else:
			host.creator.hasscythe = true
			
			
		if name == "Scythe" && current_tick % 5 == 0 && !host.is_ghost:
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))
			
		if current_tick > 20 && name == "Scythe" :
			if pos.x > cpos.x:
				host.apply_force(-1,0)
				host.move_directly(-2,0)
			else:
				host.apply_force(1,0)
				host.move_directly(2,0)
			if pos.y > cpos.y - 16:
				host.apply_force(0,-1)
				host.move_directly(0,-2)
			else:
				host.apply_force(0,1)
				host.move_directly(0,2)
					
			if abs(pos.x - cpos.x) < 26 && abs(pos.y - host.creator.get_hurtbox_center_float().y) < 30:
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx1.tscn"), Vector2(cpos.x,host.creator.get_hurtbox_center_float().y), Vector2(host.get_facing_int(), 0))
				if camera && !host.is_ghost:
					camera.bump(Vector2(), 5, 10/ 60.0)
				host.creator.storedmeter += 65
				fizzle()
				
		if host.creator.current_state().name == "Recall":
			if host.creator.current_state().current_tick < 6:
				pass
			else:
				if host.creator.current_state().current_tick == 6:
					host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx1.tscn"), Vector2(pos.x,pos.y - 10), Vector2(host.get_facing_int(), 0))
				host.set_vel(host.creator.current_state().data.x/6,host.creator.current_state().data.y/10)
					
					
					
	if name == "ShardB":
		if current_tick == 0:
			host.id = host.creator.id
			host.can_be_hit_by_melee = true
			host.creator.play_sound("skate")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x,pos.y - 4), Vector2(host.get_facing_int(), 0))
			
		if current_tick == 19 + int(state_screenshake_dir.x == 1) * 20 :
			host.gravity = "0"
			host.creator.play_sound("scythe")
			host.creator.play_sound("phonk1")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x,pos.y), Vector2(host.get_facing_int(), 0))

	if name == "ShardC":
		
		if int(host.get_vel().y) < -12:
			host.apply_force(0, -11 - int(host.get_vel().y))
		
		if current_tick % 3 == 0 && !host.is_ghost:
			host._create_speed_after_image( Color("3ba3ff") , 0.1)
		
		if abs(pos.x - opos.x) > 15:
			if pos.x > opos.x:
				host.apply_force(-1,0)
				if abs(pos.x - opos.x) > 40:
					host.apply_force(-1,0)
			else:
				host.apply_force(1,0)
				if abs(pos.x - opos.x) > 40:
					host.apply_force(1,0)
		else:
			host.apply_force(int(host.get_vel().x)/-2,0)
			
		if abs(pos.y - host.creator.opponent.get_hurtbox_center_float().y) > 15:
			if pos.y > host.creator.opponent.get_hurtbox_center_float().y:
				host.apply_force(0,-1)
				if abs(pos.y - host.creator.opponent.get_hurtbox_center_float().y) > 40:
					host.apply_force(0,-1)
			else:
				host.apply_force(0,1)
				if abs(pos.y - host.creator.opponent.get_hurtbox_center_float().y) > 40:
					host.apply_force(0,1)
		else:
			host.apply_force(0,int(host.get_vel().y)/-2)
		
		if abs(pos.x - opos.x) <= 20 && abs(pos.y - host.creator.opponent.get_hurtbox_center_float().y) <= 20 && (host.creator.opponent.projectile_invulnerable or host.creator.opponent.invulnerable):
			fizzle()
		if (current_tick > 45 && host.creator.hasscythe) or hitted == 1:
			fizzle()
	if name == "ShardA":
		if current_tick == 0:
			host.can_be_hit_by_melee = true
			if host.creator.current_state().name == "Conquer":
				host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x, pos.y), Vector2(host.get_facing_int(), 0))	

		if current_tick == 10:
			host.id = 300
		if host.is_grounded() or hitted == 1 or current_tick > 60:
			fizzle()
	if name == "ShardD":
		host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TySkateFFx.tscn"), Vector2(pos.x, pos.y + 4), Vector2(host.get_facing_int(), 0))
		if host.creator.opponent.combo_count > 0:
			fizzle()
		if pos.x + 10 > host.creator.stage_width or pos.x - 10 < -host.creator.stage_width: 
			fizzle()
	if name == "Idle":
		if cstate.current_tick >= 9:
			host.has_projectile_parry_window = false
			host.always_parriable = false
		if current_tick == 1:
			host.can_be_hit_by_melee = true
		if current_tick == 8:
			host.id = 300
		if current_tick > 20:
			current_tick -= 1
		if name == "Ici4":
			if host.creator.current_state().name == "Taunt":
				host.invulnerable = true
			else:
				host.invulnerable = false
			
		if (host.realtick > 300 && anim_name != "Ici4") or host.icecount > 5:
			fizzle()
	if name == "Idle2":
		if host.creator.current_state().busy_interrupt_type == 1 && host.creator.current_state().name != "Landing":
			fizzle()
		
		if current_tick == 0:
			host.creator.play_sound("skate")
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyFrostFx.tscn"), Vector2(pos.x,pos.y - 4), Vector2(host.get_facing_int(), 0))

		if current_tick > 10:
			host.realtick = 0
			return "Idle"
func fizzle():
	var pos = host.get_pos()
	host._create_speed_after_image( Color("3ba3ff") , 0.1)
	
	if name == "Scythe" or name == "Scythe2" or name == "Scythe4":
#		host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx1.tscn"), Vector2(pos.x,pos.y - 10), Vector2(host.get_facing_int(), 0))
		host.creator.hasscythe = true
		host.creator.hasscythevisual = true
		if name != "Scythe4":
			host.creator.play_sound("Block2")
			host.creator.global_hitlag(2,true)
				
	if name == "ShardA" or name == "ShardB" or name == "ShardC":
		host.creator.play_sound("frostbite4")
		host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(pos.x, pos.y), Vector2(host.get_facing_int(), 0))	
	if name == "Idle":
		host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShardSumFx.tscn"), Vector2(pos.x, pos.y -6), Vector2(host.get_facing_int(), 0))	
	
	host.disable()
	terminate_hitboxes()
