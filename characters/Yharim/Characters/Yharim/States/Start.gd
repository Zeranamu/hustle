extends CharacterState

var game_time = 3600
var state_variables = {}
onready var Portrait1 = preload("res://Yharim/Characters/Yharim/Icons/YharimPortraitP1.png")

func _enter():
	game_time = Global.current_game.time

func _frame_0():
	if not host.AchSkin:
		host.charge += 1
	for v in host.opponent.state_variables:
		state_variables[v] = host.opponent.get(v)
		if host.id == 1:
			get_node("/root/Main/HudLayer/HudLayer/VBoxContainer/TopBar/P1Portrait").texture = Portrait1
			get_node("/root/Main/HudLayer/HudLayer/VBoxContainer/TopBar/P1Portrait").modulate = Color(1,1,1) #removes the blue/red tint, remove this line if you want to keep it
		else:
			get_node("/root/Main/HudLayer/HudLayer/VBoxContainer/TopBar/P2Portrait").texture = Portrait1
			get_node("/root/Main/HudLayer/HudLayer/VBoxContainer/TopBar/P2Portrait").self_modulate = Color(1,1,1) #removes the blue/red tint, remove this line if you want to keep it
	if host.id == 2 and not Network.multiplayer_active:
		host.charge -= 1
func _frame_2():
	if host.is_fight_Catbox() or host.is_Special():
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.unlock_achievement(host, "Catbox", true)
	if host.SKIN and not host.AchSkin:
		timed_particle_scene = preload ("res://Yharim/Characters/Yharim/Fx/GodRaysSpecial.tscn")
	if host.getOpponentName() == "Yharim":
		host.spawn_particle_effect_relative(host.INTROMirror1, Vector2(0, -45))
	elif host.getOpponentName() == "Terrarian":
		host.spawn_particle_effect_relative(host.INTROTerr1, Vector2(0, -45))
	elif host.getOpponentName() == "Nocturne":
		host.spawn_particle_effect_relative(host.INTROGod1, Vector2(0, -45))
	elif host.getOpponentName() == "Syrim":
		host.spawn_particle_effect_relative(host.INTROSyrim1, Vector2(0, -45))
	elif host.getOpponentName() == "Robot":
		host.spawn_particle_effect_relative(host.INTRORobot1, Vector2(0, -45))
	elif host.getOpponentName() == "Niflheim":
		host.spawn_particle_effect_relative(host.INTRONif1, Vector2(0, -45))
	elif host.getOpponentName() == "HAG":
		host.spawn_particle_effect_relative(host.INTROHAG1, Vector2(0, -45))
	elif host.getOpponentName() == "Miko":
		host.spawn_particle_effect_relative(host.INTROMiko1, Vector2(0, -45))
	elif host.getOpponentName() == "Mutant":
		host.spawn_particle_effect_relative(host.INTROMutant1, Vector2(0, -45))
	elif host.getOpponentName() == "Wizard":
		host.spawn_particle_effect_relative(host.INTROWizard1, Vector2(0, -45))
	elif host.getOpponentName() == "Colossus":
		host.spawn_particle_effect_relative(host.INTROColos1, Vector2(0, -45))
	elif host.getOpponentName() == "Executioner":
		host.spawn_particle_effect_relative(host.INTROExe1, Vector2(0, -45))
	else:
		host.spawn_particle_effect_relative(host.INTRO1, Vector2(0, -45))
	host.play_sound("IntroSFX")
func _frame_60():
	if host.AchSkin:
		host.charge += 1
		var obj = host.spawn_object(host.INTROLIGHTING, 0, 0, true, data)
		obj.set_facing(host.get_facing_int())
	if host.getOpponentName() == "Yharim":
		host.spawn_particle_effect_relative(host.INTROMirror2, Vector2(0, -45))
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.unlock_achievement(host, "Dreadon", true)
	elif host.getOpponentName() == "Nocturne":
		host.spawn_particle_effect_relative(host.INTROGod2, Vector2(0, -45))
	elif host.getOpponentName() == "Syrim":
		host.spawn_particle_effect_relative(host.INTROSyrim2, Vector2(0, -45))
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.unlock_achievement(host, "Dreadon", true)
	elif host.getOpponentName() == "Robot":
		host.spawn_particle_effect_relative(host.INTRORobot2, Vector2(0, -45))
	elif host.getOpponentName() == "Niflheim":
		host.spawn_particle_effect_relative(host.INTRONif2, Vector2(0, -45))
	elif host.getOpponentName() == "HAG":
		host.spawn_particle_effect_relative(host.INTROHAG2, Vector2(0, -45))
	elif host.getOpponentName() == "Illuko":
		host.spawn_particle_effect_relative(host.INTROILLUKO, Vector2(0, -45))
	elif host.getOpponentName() == "Miko":
		host.spawn_particle_effect_relative(host.INTROMiko2, Vector2(0, -45))
	elif host.getOpponentName() == "Mutant":
		host.spawn_particle_effect_relative(host.INTROMutant2, Vector2(0, -45))
	elif host.getOpponentName() == "Wizard":
		host.spawn_particle_effect_relative(host.INTROWizard2, Vector2(0, -45))
	elif host.getOpponentName() == "Colossus":
		host.spawn_particle_effect_relative(host.INTROColos2, Vector2(0, -45))
	elif host.getOpponentName() == "Executioner":
		host.spawn_particle_effect_relative(host.INTROExe2, Vector2(0, -45))
	else:
		host.spawn_particle_effect_relative(host.INTRO2, Vector2(0, -45))

func _tick():
	host.penalty = 0
	host.opponent.penalty = 0
	var game = Global.current_game
	if(game.time-game.current_tick<game_time):
		game.time+=1
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
