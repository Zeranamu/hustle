extends CharacterState

var game_time = 3600
var state_variables = {}
var master_sfx = true

func _enter():
	game_time = Global.current_game.time

func _frame_0():
	for v in host.opponent.state_variables:
		state_variables[v] = host.opponent.get(v)

func _tick():
	host.start_invulnerability()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	var spr_dir = host.get_facing_int()
	var camera = host.get_camera()
	var game = Global.current_game
	host.Frost = 0.0
	host.penalty = 0
	host.opponent.penalty = 0
	host.colliding_with_opponent = false
	
	if host.opponent.get("crossintro") == true:
		return "CrossIntro"
		
	if(game.time-game.current_tick<game_time):
		game.time+=1
	if host.opponent.stance == "Intro" && current_tick == 2:
		if host.opponent.get("charname") == "Cress" and pos.x > opos.x:
			master_sfx = false
			
	if host.opponent.stance != "Intro" and current_tick < 119:
		for v in state_variables.keys():
			host.opponent.set(v,state_variables[v])
		host.opponent.hitlag_ticks = 1
		host.opponent.state_interruptable = false
	if current_tick == 119:
		host.opponent.state_interruptable = true
		host.state_interruptable = true
		host.stance = "Normal"
		return "Wait"
		
	if current_tick == 0:
		if master_sfx == true:
			host.play_sound("winter1")
		host.move_directly(3*80*spr_dir,0)
		host.set_facing(spr_dir*-1)
	elif current_tick < 81:
		if current_tick % 3 == 0:
			host.start_super(1)
		host.move_directly(3*spr_dir,0)
		if current_tick % 10 == 0:
			host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyDashFx.tscn"), Vector2(pos.x,pos.y-20), Vector2(host.get_facing_int(), 0))
		if master_sfx == true:
			if current_tick % 15 == 0:
				host.play_sound("step")
	if current_tick == 85:
		host.set_facing(spr_dir*-1)
		if master_sfx == true:
			host.play_sound("scythe")
			host.play_sound("phonk1")
			host.play_sound("swing1")
			
	if current_tick == 90:
		if master_sfx == true:
			if camera && !host.is_ghost:
				host.play_sound("phonk2")
				camera.bump(Vector2(), 8, 8/ 60.0)
		host.spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyBlockFx.tscn"), Vector2(pos.x,pos.y-16), Vector2(host.get_facing_int(), 0))

		
		
