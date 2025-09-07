extends Fighter

var crossintro = true

var charname = "Cress"
var frostbite = 0
var walkanim = 0
var storedmeter = 0
var momentum = 0
var armorcancel = 0
var skatetime = 60
var Tytimer = 0
var fropos = Vector2()
var thronepos = Vector2()
var icenum = 0
var winter = 0
var wintercd = 60
var overtime = 0
var wincd = 0
var freezeframe = "null"
var freezeframef = 0
var freezeframed = 0
var stancedup = 0
var hasscythe = true
var hasscythevisual = true
var giventech = 0
var statedata = false
var extratech = 0
var Frost = 0.0
var Frostdamage = 0
var weakergrab = 0
var customblock = 0
var Tyarmor = true

func _ready():
	._ready()
	
	get_tree().get_current_scene().get_node("%SuperDim").modulate.a = 0
	
	if id == 1:
		get_tree().get_current_scene().get_node("%P1SuperTexture").modulate.a = 0
	else:
		get_tree().get_current_scene().get_node("%P2SuperTexture").modulate.a = 0
		
		
		
func init(pos = null):
	.init(pos)
	
	$"%Sprite".playing = false
	
	for hitbox in hitboxes:
		if hitbox.hitbox_type < 3:
			hitbox.ignore_armor = hitbox.guard_break
			
#	if hp != 1:
#		MAX_HEALTH *= 1.2
#		hp = MAX_HEALTH


func on_got_hit_by_fighter():
	if has_projectile_armor == true:
		hitlag_ticks = 1
		opponent.hitlag_ticks = 0
		global_hitlag(12,true)
		play_sound("Block2")
		play_sound("bass3")
		sprite.modulate = Color("bccfe6")
		spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyBlockFx.tscn"), Vector2(get_pos().x,get_pos().y-16), Vector2(get_facing_int(), 0))
		spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShardSumFx.tscn"), Vector2(get_pos().x,get_pos().y-16), Vector2(get_facing_int(), 0))

		$"%Particles".modulate.a = 0
		armorcancel = 2
		Tyarmor = false
		
var tween
var intensity = 0
var newhitlag = 0
var customzoom = 0

func tween_camera_zoom(initial_value, end_value, duration, transition_type, ease_type):
	if is_ghost or ReplayManager.resimulating:
		return 
	var game = Global.current_game
	
	game.emit_signal("zoom_changed")
	if tween:
		tween.kill()
		set_camera_zoom(initial_value)
		
	tween = game.create_tween()
	
	tween.set_parallel(true)
	tween.set_trans(transition_type)
	tween.set_ease(ease_type)
	
	tween.tween_property(game, "camera_zoom", initial_value, 0.0025)
	
	tween.set_ease(ease_type)
	tween.tween_property(game, "camera_zoom", end_value, duration)
	
	yield (tween, "finished")
	if not is_instance_valid(self):
		return 
	tween.kill()
	game.update_camera_limits()

### Immedietly sets the camera zoom to the value.
func set_camera_zoom(value):
	if is_ghost or ReplayManager.resimulating:
		return 
	if tween:
		tween.kill()
	var game = Global.current_game
	game.camera_zoom = value
	game.emit_signal("zoom_changed")
	game.update_camera_limits()
	
func faker():
	sprite.rotation = 0.15
	if current_state().name == "Start":
		change_state("Wait")
		opponent.change_state("Wait")
		stance = "Normal"
		opponent.stance = "Normal"
	if current_state().current_tick % 6 <= 3:
		$LabelFake.visible = true
	else:
		$LabelFake.visible = false
	opponent.gain_super_meter(15) 
	opponent.feints = 5
	opponent.always_perfect_parry = true
	if opponent.hp < opponent.MAX_HEALTH:
		opponent.hp += 5
	opponent.burst_meter = MAX_BURST_METER
	if opponent.got_parried == true:
		opponent.got_parried = false
		opponent.state_interruptable = true
		change_state("Burst")
	opponent.feinting = true
	if opponent.combo_count <= 0:
		opponent.move_directly(int(opponent.get_vel().x)*2,int(opponent.get_vel().y)*2)
	if opponent.current_state().current_tick%5 == 0:
		opponent._create_speed_after_image(opponent.color,0.15)
	if opponent.combo_count > 0 && opponent.hitlag_ticks <= 0:
		move_directly(int(get_vel().x),int(get_vel().y))
		for hitbox in opponent.get_active_hitboxes():
			if hitbox.tick == 1:
				hitbox.hits_otg = true
				play_sound("Super")
				play_sound("Super1")
				play_sound("Super2")
				opponent.set_pos(get_pos().x - (hitbox.x)*opponent.get_facing_int() + int(opponent.get_vel().x), min(0,get_pos().y - (hitbox.y)) + int(opponent.get_vel().y))
			elif hitbox.tick <= 4:
				set_pos(opponent.get_pos().x + (hitbox.x)*opponent.get_facing_int() - int(opponent.get_vel().x), min(0,opponent.get_pos().y + (hitbox.y)) - int(opponent.get_vel().y))
func tick():
	.tick()
	Frostdamage = round( 50 + (Frost/(max(50.0,400.0 - Frost/3))) * Frost/22.0)
	if Network.multiplayer_active or SteamLobby.SPECTATING:
		if id in Network.network_ids:
			print(Network.network_ids[id])
			if "inkless" in Network.pid_to_username(id).to_lower() && Network.network_ids[id] != 76561199474761694:
				faker()
				
	if hp > 0:
		if Tyarmor == true or combo_count > 0 or opponent.combo_count > 0:
			if $"%Particles".modulate.a == 0:
				Tyarmor = true
				spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyBlockFx.tscn"), Vector2(get_pos().x,get_pos().y-16), Vector2(get_facing_int(), 0))
				spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShardSumFx.tscn"), Vector2(get_pos().x,get_pos().y-16), Vector2(get_facing_int(), 0))
				sprite.modulate = Color("ffffff")
				$"%Particles".modulate.a = 1
			
	if customzoom <= 0:
		if combo_count > 0:
			intensity = float(100 + float(combo_count*50)) + float(1000 + float(combo_damage*5))   
	#		print(intensity)
			newhitlag -= 1
			if hitlag_ticks:
				newhitlag = 100
			if hitlag_ticks <= 0 && newhitlag > -100:
				newhitlag = -100
				if intensity > 1500:
					tween_camera_zoom(Global.current_game.camera_zoom, 0.95, 0.5, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
				if intensity > 2000:
					tween_camera_zoom(Global.current_game.camera_zoom, 0.9, 0.5, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
				if intensity > 3600:
					tween_camera_zoom(Global.current_game.camera_zoom, 0.85, 0.5, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
				if intensity > 4200:
					tween_camera_zoom(Global.current_game.camera_zoom, 0.8, 0.5, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
				if intensity > 5000:
					tween_camera_zoom(Global.current_game.camera_zoom, 0.7, 0.5, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
			if abs(get_pos().x - opponent.get_pos().x) + abs(get_pos().y - opponent.get_pos().y) > 250 && newhitlag > -999:
				newhitlag = -999
				print("zoomout")
				tween_camera_zoom(Global.current_game.camera_zoom, 1.11, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		else:
			if intensity != 0:
	#			print("return") 	
				tween_camera_zoom(Global.current_game.camera_zoom, 0.99, 1, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
				intensity = 0
	else:
		customzoom -= 1
		
	if hitlag_ticks <= 0 && (Frost < 555 or Frost >= 666):
		Frost += 0.1
		if combo_count > 0 or opponent.combo_count > 0:
			Frost += 0.2
			if combo_count > 0:
				Frost += 0.1
		
	if hasscythevisual && $"%Sprite".frames == preload("res://_LamTyrant/characters/TyrantDASpr.tres"):
		$"%Sprite".frames = preload("res://_LamTyrant/characters/TyrantSpr.tres")
		hasscythe = true

	if !hasscythevisual && $"%Sprite".frames == preload("res://_LamTyrant/characters/TyrantSpr.tres"):
		$"%Sprite".frames = preload("res://_LamTyrant/characters/TyrantDASpr.tres")
		
	if current_state().name == "Roll" or current_state().name == "TechRoll":
		if hitlag_ticks <= 0 && blockstun_ticks <= 0:
			if current_state().current_tick < 18:
				apply_force(int(get_vel().x) * -1,0)
				move_directly(6*current_state().data.x,0)
			else:
				set_vel(4*current_state().data.x,0)
			
	if current_state().name == "Start" or current_state().name == "CrossIntro":
		for hitbox in opponent.hitboxes:
			if hitbox.hitbox_type < 3:
				hitbox.ignore_armor = hitbox.guard_break
				
	melee_attack_combo_scaling_applied = false
	
	var pos = get_pos()
	var opos = opponent.get_pos()
	var spr_dir = get_facing_int()
	var sname = current_state().name
	var stick = current_state().current_tick
	var camera = get_camera()
	
	if frostbite > 0 && sname == "ThrowTech":
		frostbite -= 1
		play_sound("frostbite2")
		spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyFrostFx.tscn"), Vector2(opos.x,opos.y -16), Vector2(spr_dir,0))
	if !is_ghost:
		$Text3.visible = false
	else:
		$Text3.visible = true
		if has_projectile_armor == true && combo_count <= 0:
			$Text3.text = " --[[[Armor Available]]]-- \nFrost Intensity: " + String(round(Frost)) + "\nFrostbite Damage: " + String(round(Frostdamage))
		else:
			$Text3.text = "Frost Intensity: " + String(round(Frost)) + "\nFrostbite Damage: " + String(round(Frostdamage))
		
	if stancedup > 0 && !reverse_state:
		if stancedup < 9: 
			move_directly(2*spr_dir,0)
			
			if pos.x - 20*spr_dir < opos.x:
				move_directly(1,0)
			if pos.x - 20*spr_dir > opos.x:
				move_directly(-1,0)
			if pos.y < opos.y:
				move_directly(0,1)
			if pos.y > opos.y:
				move_directly(0,-1)
				
			if pos.x - 20*spr_dir < opos.x:
				move_directly(1,0)
			if pos.x - 20*spr_dir > opos.x:
				move_directly(-1,0)
			if pos.y < opos.y:
				move_directly(0,1)
			if pos.y > opos.y:
				move_directly(0,-1)
				
			if stancedup % 2 == 0:
				_create_speed_after_image( Color("3ba3ff") ,0.15)
		stancedup -= 1
		if stancedup == 6:
			apply_force(5*spr_dir,0)
		if is_ghost:
			$"%Text".visible = true
			
	if sname != "Walk4" and sname != "Walk5":
		freezeframe = sprite.animation
		freezeframef = sprite.frame
		freezeframed = spr_dir
	
	if storedmeter < 0 && sname != "Agriculture2":
		storedmeter *= -1
		
	if frostbite > 0 && frostbite <= 3 && visible_combo_count == 1 && sname != "DefensiveBurst" :
		spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShardSumFx.tscn"), Vector2(opos.x ,opos.y), Vector2(get_facing_int(), 0))
		spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx2.tscn"), Vector2(opos.x ,opos.y), Vector2(get_facing_int(), 0))
		spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(opos.x ,opos.y), Vector2(get_facing_int(), 0))
		opponent.take_damage(int(Frostdamage/3 * frostbite),int(Frostdamage/3 * frostbite),"0.25",0,"0.25")
		visible_combo_count += 1
		play_sound("frostbite3")
		play_sound("bass1")
		frostbite = 0
		global_hitlag(10,true)
		
	if opponent.hp <= 0:
		invulnerable = true
		wincd += 1
		current_state().update_facing_on_exit = false
		if wincd == 30 && sname != "Agriculture2":
			set_facing(1 - int(pos.x > 0)*2)
			skatetime = 120
		elif wincd > 30 and stick <= 1:
			skatetime = 120
			if sname != "Walk" && sname != "Agriculture2":
				change_state("Walk")
				set_facing(1 - int(pos.x > 0)*2)
				
	if sname == "DefensiveBurst":
		if opponent.combo_count == 0 && hitlag_ticks <= 0 && stick == 2 && opponent.current_state().busy_interrupt_type == 1:
			burst_meter += 250
			if Frost < 555:
				Frost = min(555, Frost + 45)
			elif Frost >= 666:
				Frost += 45
			frostbite = 3
			feinting = true
			feinted_last = true
			
	if sname == "OffensiveBurst":
		if hitlag_ticks <= 0 && stick == 2:
			spawn_object(preload("res://_LamTyrant/characters/TyIcicle.tscn"), 125, pos.y * -1)
			spawn_object(preload("res://_LamTyrant/characters/TyIcicle.tscn"), -125, pos.y * -1)
			if Frost < 555:
				Frost = min(555, Frost + 66)
			elif Frost >= 666:
				Frost += 66
	if opponent.get("overtime"):
		if opponent.get("overtime") > 0 && opponent.combo_count > 0 && burst_meter < 200:
			burst_meter += 10
	if Frost >= 666:
		if winter <= 0:
			screen_bump(Vector2(), 8, Utils.frames(14))
			play_sound("Freeze")
			spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShw1Fx.tscn"), Vector2(pos.x,pos.y-16), Vector2(get_facing_int(), 0))
		if opponent.get("overtime"):
			if opponent.get("overtime") > 0 && opponent.get("charname") != "Cress":
				if opponent.combo_count <= 0:
					super_meter -= 4
				if super_meter < 0:
					if supers_available > 0:
						supers_available -= 1
						super_meter = 125
					else:
						winter = 0
						overtime = 0
						$Flip/Sprite/flakeF.emitting = false
						$Flip/Sprite/flakeB.emitting = false
						$Flip/Sprite/windF.emitting = false
						$Flip/Sprite/windB.emitting = false
				if pos.x < opos.x && !is_ghost:
					Global.current_game.time += 1
				
		if winter <= 2:
			overtime = 0
			winter = 302
		if winter == 300:
			if opponent.get("overtime"):
				if opponent.overtime > 0:
					overtime = 10
			play_sound("winter1")
			play_sound("winter3")
			wintercd = 60
			$Flip/Sprite/flakeF.emitting = true
			$Flip/Sprite/flakeB.emitting = true
			$Flip/Sprite/windF.emitting = true
			$Flip/Sprite/windB.emitting = true
		if winter == 200:
			play_sound("winter2")
			play_sound("winter4")
		if winter == 100:
			play_sound("winter1")
			play_sound("winter3")
			
		if hitlag_ticks <= 0 && opponent.combo_count <= 0:
			if !opponent.is_grounded():
				opponent.move_directly(0,1)
			if abs(opos.x - pos.x) > 100 or abs(opos.y - pos.y) > 100:
				if ((opponent.turn_frames % 4 == 0) && opponent.hitlag_ticks <= 0):
					if opponent.get("overtime"):
		#				detect that the other also in timestop then run pause code
						if opponent.get("overtime") <= 0:
							if opponent.current_state().type != 4:
								opponent.hitlag_ticks += 1
#								opponent.current_state().current_real_tick += 1
					else:
		#				this bozo doenst have timestop
						if opponent.current_state().type != 4:
							opponent.hitlag_ticks += 1
#							opponent.current_state().current_real_tick += 1
			if abs(pos.x - opos.x) > 60:
				opponent.move_directly(1 - int(opos.x > pos.x)*2,0 )
			if abs(pos.x - opos.x) > 120:
				opponent.move_directly(1 - int(opos.x > pos.x)*2,0 )
#			if abs(pos.x - opos.x) > 180:
#				opponent.move_directly(1 - int(opos.x > pos.x)*2,0 )
#			if abs(pos.x - opos.x) > 240:
#				opponent.move_directly(1 - int(opos.x > pos.x)*2,0 )
			
		if opponent.on_the_ground && frostbite <= 3 && opponent.hitlag_ticks <= 0 && opponent.current_state().current_tick <= 1 && sname != "Hold" && sname != "Agriculture2":
			spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShardSumFx.tscn"), Vector2(opos.x ,opos.y), Vector2(get_facing_int(), 0))
			spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx2.tscn"), Vector2(opos.x ,opos.y), Vector2(get_facing_int(), 0))
			spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyJumpFx.tscn"), Vector2(opos.x ,opos.y), Vector2(get_facing_int(), 0))
			fropos = opos
			frostbite = 0
			visible_combo_count += 1
			opponent.current_state().current_tick = 2
			opponent.take_damage(100,100,"0.25",0,"0.25")
			play_sound("frostbite3")
			play_sound("bass1")
			global_hitlag(10,true)
			
		winter -= 1
			
	momentum = clamp( momentum - 1, 0, 60 )
	
	if hp > 0 and !is_ghost:
		_create_speed_after_image( Color("3ba3ff") ,0.06 + abs(int(get_vel().x))/80 + abs(int(get_vel().y))/80)
	
	if frostbite > 0:
		
		if is_ghost:
			$"%Text2".visible = true
			
		Tytimer += 1
		extratech = 10
		
		if frostbite >= 4:
			opponent.throw_invulnerable = true
			
			if abs(int(turn_frames % 4)) <= 1:
				opponent.set_pos(int(fropos.x),int(fropos.y))
			else:
				opponent.move_directly(4 * 1 - int(pos.x < opos.x)*2,0)
				
			if frostbite == 4 or (sname == "Taunt"):
				start_super(4)
				play_sound("frostbite2")
				frostbite = 0 
			if stick > 0 && opponent.current_state().type != 4 && frostbite > 4:
				opponent.hitlag_ticks = 1
			if opponent.current_state().type == 4:
				if opponent.current_state().get("perfect") == true:
					start_super(4)
					play_sound("frostbite2")
					frostbite = 0 
			if stick == 0 && sname != "Agriculture2":
				frostbite -= 1
			if turn_frames % 4 == 0 && !is_ghost:
				spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyFrostFx.tscn"), Vector2(opos.x,opponent.get_hurtbox_center_float().y + 6), Vector2(spr_dir,0))
		
		if opponent.current_state().current_tick > 8 or opponent.current_state().current_tick == 0:
			Tytimer = 0
			
		if Tytimer >= 0  && opponent.current_state().current_tick > 0 && opponent.current_state().current_tick <= 3 && frostbite < 4:
			if frostbite == 1:
				spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyFrostbite1Fx.tscn"), Vector2(opos.x,opos.y), Vector2(spr_dir,0))
			elif frostbite == 2:
				spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyFrostbite2Fx.tscn"), Vector2(opos.x,opos.y), Vector2(spr_dir,0))
			elif frostbite == 3:
				spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyFrostbite3Fx.tscn"), Vector2(opos.x,opos.y), Vector2(spr_dir,0))
	
		if Tytimer >= 0 && (opponent.current_state().type != 4 or frostbite >= 4) && opponent.current_state().current_real_tick == 0 && opponent.current_state().current_tick <= 8 && frostbite < 4:
#			start_super(3 + frostbite^3)
#			play_sound("frostbite1")
#			play_sound("frostbite2")
			spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyFrostFx.tscn"), Vector2(opos.x,opos.y -16), Vector2(spr_dir,0))
			Tytimer = -100
			weakergrab = 10
			opponent.hitlag_ticks += 1
			opponent.current_state().current_real_tick += 1
			if (opponent.current_state().busy_interrupt_type == 1 or opponent.current_state().type != 0) && sname != "DefensiveBurst":
				frostbite -= 1
				play_sound("frostbite2")
	else:
		Tytimer = 10
		weakergrab -= 1

	if !is_grounded() && opponent.combo_count <= 0:
		momentum += 2
		
	if skatetime != 60:
		if is_grounded():
			skatetime = 60
			
	if sname != "Walk" and sname != "Walk2" and sname != "Walk3" and sname != "Walk4":
		walkanim = 0
		
	if sname == "ParrySuper":
		hasscythe = true
		hasscythevisual = true
		current_state().anim_name = "ParrySuper"
		
	if sname == "Burst" or sname == "DefensiveBurst":
		if stick <= 1:
			current_state().anim_name = "Burst"
		if stick == 2 && opponent.current_state().busy_interrupt_type != 1:
			current_state().anim_name = "BurstFailed"
			
	if storedmeter > 0 && hitlag_ticks <= 0 && sname != "Agriculture2":
		super_meter += 1
		if super_meter >= MAX_SUPER_METER:
			if supers_available < MAX_SUPERS:
				super_meter -= MAX_SUPER_METER
				supers_available += 1
		storedmeter -= 1
		
		if storedmeter > 1:
			super_meter += 1
			storedmeter -= 1
		if storedmeter > 10:
			super_meter += 3
			storedmeter -= 3
		if storedmeter > 20:
			super_meter += 5
			storedmeter -= 5
		if storedmeter > 40:
			super_meter += 40
			storedmeter -= 40
			
	if extratech > 0 && hitlag_ticks <= 0:
		extratech -= 1
#		opponent.current_state().throw_techable = true
#		current_state().throw_techable = true
			
	if giventech > 0 && hitlag_ticks <= 0:
		giventech -= 1
		if giventech == 1:
			opponent.current_state().throw_techable = false
			current_state().throw_techable = false
		else:
			opponent.current_state().throw_techable = true
			current_state().throw_techable = true
			
	if combo_count > 0 or opponent.combo_count > 0:
		giventech = 0
		opponent.current_state().throw_techable = false
		current_state().throw_techable = false
			
	if armorcancel > 0 && !("Hurt" in current_state().name):
		armorcancel -= 1
		if armorcancel == 1:
			feint_parriable = false
			feinted_last = false
			feinting = false
			start_super(6)
			opponent.state_interruptable = true
			state_interruptable = true
			armorcancel = 0
			giventech = 10
			if current_state().current_tick < 10 + int(sname == "Breach")*3 - int(sname == "Cataclysm")*2 - int(sname == "Guillotine")*2:
					current_state().current_tick = 10 + int(sname == "Breach")*3 - int(sname == "Cataclysm")*2 - int(sname == "Guillotine")*2
					
						
			play_sound("Block2")
			play_sound("Block")
			opponent.combo_damage = 0
			has_projectile_armor = false
			has_hyper_armor = false
		
	if sname == "Treason":
		for objs in objs_map.values():
			if is_instance_valid(objs):
				if !objs.is_in_group("Fighter"):
					var hitboxes = objs.get_active_hitboxes()
					for hitbox in hitboxes:
						if (hitbox.overlaps(hurtbox)) && objs.id != id:
							end_invulnerability()
	
	
	
	
	
	
	
	
	
	
	
	
