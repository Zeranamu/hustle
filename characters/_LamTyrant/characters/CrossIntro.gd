extends CharacterState


var ogx = 0
onready var mastersfx = false

func _enter():
	apply_forces = false
	apply_fric = false
	apply_grav = false
	anim_length = 999
	endless = true
	if name == "CrossIntro":
		ticks_per_frame = 3
	else:
		ticks_per_frame = 6
	endless = true 
	ogx = host.get_pos().x - 80*host.get_facing_int()
	ogx = host.get_pos().x - 80*host.get_facing_int()
	
func _exit():
	host.release_camera_focus()
	
func _tick():
	var spr_dir = host.get_facing_int()
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	host.start_invulnerability()
	host.set_vel(0,0)
	host.penalty = 0
	host.opponent.penalty = 0
	host.stance = "Normal"
	
	if pos.x < opos.x && !host.is_ghost:
		 Global.current_game.time += 1
	#in here it determine mastersfx for a mirror so only 1 character playing unique sfx
	if name == "CrossIntro":
		if current_tick == 0:
			if (host.opponent.get_pos().x > host.get_pos().x && host.opponent.charname == host.charname) or host.opponent.charname != host.charname:
				mastersfx = true
	#Charging
		if current_tick >= 0 && current_tick < 11*3:
			if current_tick == 1:
				if mastersfx:
#					host.play_sound("Swingh1")
					pass
			host.set_pos(-1000*spr_dir + 30*current_tick*spr_dir, -240 + current_tick*2)
			
	#Clashing 1 2 3
		if current_tick == 11*3 or current_tick == 14*3 or current_tick == 17*3:
			host.set_pos(-40*spr_dir, pos.y - 20)
			if mastersfx:
#				host.play_sound("")
				pass
#			host.spawn_particle_effect(preload(""), Vector2(0,opos.y-18), Vector2(1, 0))
			pass
			if pos.x > opos.x:
				host.screen_bump(Vector2(), 6.0, 8/60.0)
				host.start_super(6)
				
	#Clashing Final
		if current_tick == 22*3:
			if pos.x > opos.x:
				host.screen_bump(Vector2(), 8.0, 14/60.0)
			if mastersfx:
#				host.play_sound("")
				pass
#			host.spawn_particle_effect(preload(""), Vector2(0,opos.y-18), Vector2(1, 0))

	#Movement
		if current_tick >= 11*3 && current_tick < 20*3:
			host.move_directly(0,2)
			host.move_directly(-2*spr_dir,2)
		if current_tick >= 20*3 && current_tick < 22*3:
			host.move_directly(10*spr_dir,20)
		if current_tick >= 22*3 && current_tick < 35*3:
			if current_tick == 22*3: 
				host.set_pos(0, 0 )
			else:
				if pos.x != ogx:
					host.move_directly(-1*spr_dir,0)
				if abs(pos.x - ogx) > 8:
					host.move_directly(-2*spr_dir,0)
				if abs(pos.x - ogx) > 26:
					host.move_directly(-3*spr_dir,0)
				if abs(pos.x - ogx) > 56:
					host.move_directly(-4*spr_dir,0)
				if abs(pos.x - ogx) > 120:
					host.move_directly(-5*spr_dir,0)
				if abs(pos.x - ogx) > 200:
					host.move_directly(-6*spr_dir,0)
	#Actual Intro:
		if (current_tick >= 35*3 or (current_tick >= 32*3 && pos.x <= ogx)) && pos.x < opos.x:
			return "CrossIntro2"
			
	if name == "CrossIntro2":
		if current_tick < 10:
			host.move_directly(4*spr_dir,0)
		elif current_tick < 20:
			host.move_directly(3*spr_dir,0)
		elif current_tick < 30:
			host.move_directly(1*spr_dir,0)
		if (current_tick < 60 or (current_tick > 260 && current_tick < 320)):
			if current_tick % 4 == 0:
				host.play_sound("speak")
			if current_tick <= 80:
				$"%Dia1".percent_visible = current_tick / 58.0
				$"%Dia2".percent_visible = current_tick / 58.0
				$"%Dia3".percent_visible = 0
			if current_tick > 260 && current_tick <= 320:
				$"%Dia3".percent_visible = max((current_tick - 260) / 58.0,0)
		else:
			if current_tick > 80:
				$"%Dia1".modulate.a -= 0.02
				$"%Dia2".modulate.a -= 0.02
			if current_tick > 340:
				$"%Dia3".modulate.a -= 0.02
		if current_tick == 0:
			$"%Dia1".modulate.r = max(0.35,Color(host.color).r)
			$"%Dia1".modulate.g = max(0.35,Color(host.color).g)
			$"%Dia1".modulate.b = max(0.35,Color(host.color).b)
			
			$"%Dia2".modulate.r = max(0.35,Color(host.color).r)
			$"%Dia2".modulate.g = max(0.35,Color(host.color).g)
			$"%Dia2".modulate.b = max(0.35,Color(host.color).b)
			
			$"%Dia3".modulate.r = max(0.35,Color(host.color).r)
			$"%Dia3".modulate.g = max(0.35,Color(host.color).g)
			$"%Dia3".modulate.b = max(0.35,Color(host.color).b)
#			host.play_sound("")
			host.grab_camera_focus()
			#1st speech
			if pos.x < opos.x:
				$"%Dia1".visible = true
			#2nd speech:
			else:
				$"%Dia2".visible = true
				
		if (current_tick == 260 && pos.x < opos.x):
#			host.play_sound("")
			anim_name = "Wait"
			host.screen_bump(Vector2(), 3.0, 4/60.0)
			#3st speech
			if pos.x < opos.x:
				$"%Dia3".visible = true
		
		if current_tick == 125 && pos.x < opos.x:
			host.release_camera_focus()
		if current_tick == 130:
			$"%Dia1".visible = false
			$"%Dia2".visible = false
			host.release_camera_focus()
			if pos.x < opos.x:
				host.opponent.change_state("CrossIntro2")
				
		if (current_tick == 260 && pos.x > opos.x):
#			host.play_sound("")
			host.screen_bump(Vector2(), 3.0, 4/60.0)
			if !host.is_ghost:
				Global.current_game.time += 10
			return "Wait"
			
		if (current_tick == 390 && pos.x < opos.x):
			$"%Dia3".visible = false
			return "Wait"
	#Dialog storage 
		if host.charname == "":
			if host.opponent.charname == "Specificchar":
				$"%Dia1".text = "Specific"
				$"%Dia2".text = "Specific"
				$"%Dia3".text = "Specific"
			else:
				#neutralspeech
				$"%Dia1".text = "Neutral"
				$"%Dia2".text = "Neutral"
				$"%Dia3".text = "Neutral"
