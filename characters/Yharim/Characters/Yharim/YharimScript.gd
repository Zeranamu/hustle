extends Fighter

const combo_thresholds = [4, 7, 9, 11, 13, 15, 17]
const special = ["Catbox","Ozzatron","Dia","Death","Script","Mana","NightDev","Cherry","triple","Nezriani","Hayabo-of-the-so","Videofreak","Sugar_Father","Kanavaer","HellYeah!!!","Trinity","spooderp","IppoCooking", "player_sans9", "playersans21", ""]
var charname = "Yharim"

var charge = 0
var charged_this_turn = false
var Overcharge = false
var CT = 300
var OCT = false
var over = 0
var install = false
var timer = false
var time = 40
var tween
var sweet = false
var lorde = false
var neu = true
var SKIN = false
var shoot = 0
var limit = false
var GSP = false
var snap = 0
var switch = false
var reducebutton = false
var LORDE = false
var Crystal = false
var win = false
var options_applied = false
var AchSkin = false
var AchFail = false
var touhou = false
# Beams
onready var beam = $"%YBeam"
onready var BSTART = preload ("res://Yharim/Characters/Yharim/Fx/Beams/BeamStartUp.tscn")
onready var BEAM = preload ("res://Yharim/Characters/Yharim/Fx/Beams/BeamParticleEffect.tscn")
onready var BEND = preload ("res://Yharim/Characters/Yharim/Fx/Beams/BeamEnd.tscn")
# LORDE Beam
onready var BEAMl = preload ("res://Yharim/Characters/Yharim/Fx/Beams/BeamParticleEffectLORDE.tscn")
onready var BENDl = preload ("res://Yharim/Characters/Yharim/Fx/Beams/BeamEndLORDE.tscn")
# Beta Tester beam
onready var BSTARTsk = preload ("res://Yharim/Characters/Yharim/Fx/Beams/BeamStartUpSKIN.tscn")
onready var BEAMsk = preload ("res://Yharim/Characters/Yharim/Fx/Beams/BeamParticleEffectSKIN.tscn")
onready var BENDsk = preload ("res://Yharim/Characters/Yharim/Fx/Beams/BeamEndSKIN.tscn")
# Achivment skin beam
onready var BSTARTa = preload ("res://Yharim/Characters/Yharim/Fx/Beams/BeamStartUpSKIN2.tscn")
onready var BEAMa = preload ("res://Yharim/Characters/Yharim/Fx/Beams/BeamParticleEffectSKIN2.tscn")
onready var BENDa = preload ("res://Yharim/Characters/Yharim/Fx/Beams/BeamEndSKIN2.tscn")
# Intro Text
onready var INTROLIGHTING = preload("res://Yharim/Characters/Yharim/Projectiles/IntroSnapLighting.tscn")
onready var INTRO1 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticle1.tscn")
onready var INTRO2 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticle2.tscn")
onready var INTROMirror1 = preload("res://Yharim/Characters/Yharim/Fx/IntroMirrorTextParticle1.tscn")
onready var INTROMirror2 = preload("res://Yharim/Characters/Yharim/Fx/IntroMirrorTextParticle2.tscn")
onready var INTROGod1 = preload("res://Yharim/Characters/Yharim/Fx/IntroGodTextParticle1.tscn")
onready var INTROGod2 = preload("res://Yharim/Characters/Yharim/Fx/IntroGodTextParticle2.tscn")
onready var INTROSyrim1 = preload("res://Yharim/Characters/Yharim/Fx/IntroSyrimTextParticle1.tscn")
onready var INTROSyrim2 = preload("res://Yharim/Characters/Yharim/Fx/IntroSyrimTextParticle2.tscn")
onready var INTRORobot1 = preload("res://Yharim/Characters/Yharim/Fx/IntroRobotParticle1.tscn")
onready var INTRORobot2 = preload("res://Yharim/Characters/Yharim/Fx/IntroRobotParticle2.tscn")
onready var INTROHAG1 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleHAG1.tscn")
onready var INTROHAG2 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleHAG2.tscn")
onready var INTRONif1 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleNif1.tscn")
onready var INTRONif2 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleNif2.tscn")
onready var INTROILLUKO = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleIlluko2.tscn")
onready var INTROMutant1 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleMutant1.tscn")
onready var INTROMutant2 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleMutant2.tscn")
onready var INTROMiko1 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleMiko1.tscn")
onready var INTROMiko2 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleMiko2.tscn")
onready var INTROWizard1 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleWizard1.tscn")
onready var INTROWizard2 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleWizard2.tscn")
onready var INTROColos1 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleColos1.tscn")
onready var INTROColos2 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleColos2.tscn")
onready var INTROExe1 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleExi1.tscn")
onready var INTROExe2 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleExi2.tscn")
onready var INTROTerr1 = preload("res://Yharim/Characters/Yharim/Fx/IntroTextParticleTerr1.tscn")
# Parries
onready var default_parry = preload("res://fx/ParryEffect.tscn")
onready var custom_parry = preload("res://Yharim/Characters/Yharim/Fx/YharimParry.tscn")
# BG and Skins
onready var INSTALLBG = preload("res://Yharim/Characters/Yharim/Fx/YharimBG.tscn")
onready var INSTALLBGSPECIAL = preload("res://Yharim/Characters/Yharim/Fx/YharimBGSpecial.tscn")
onready var INSTALLBGACH = preload("res://Yharim/Characters/Yharim/Fx/YharimBGAchSkin.tscn")
onready var INSTALLBGACHSTART = preload("res://Yharim/Characters/Yharim/Fx/SkinStartEffect.tscn")
onready var lordeskin = $"%LordeSkin"
onready var red = $"%ChargeAuricBody"
onready var sp = $"%SPECIAL"
onready var ACH = $"%AchBack"


															  
#Yharim:                                      
														#+++                                        
													 #++++++                                        
											   ##+++++++++++##+##          ++#                      
											##++++++++++++++++++++++++++++++++                      
										   #+++++++++++++++++++++++++++++++++                       
										 #+++++++++++++++++++++++++++++++++++                       
									#    ++++++++++++++++++++++++++++++++++++++#                    
									##++++++++++++++++++++++++++++++++++++++++++++                  
									 #+++#+++++++++++++++++++++++++++++++++++++++++#                
									  #++++#+++++++++++++++++++++++++++++++++++++++++               
									  #+++++++++++++++++++++++++++++++++++++++++++++++              
									  #+++++++++++++-++++++-#++++-+++++++++++++++++++++             
									  #+++++++#++++--+####+--#+---+++++++++++++++++++++             
					   #++##+#+       ++++++++----+---+####+-+----+++++++++++++++++++++             
					  #+--++----+     ##++++++-----+-+####++++--+++++++++++++++++++++++#            
  #                   ++-+----+#++      #+++++++++--++--+##+--++-++++++++++++++++++++++ +            
				  #+--++-------#++       ###++++++#-#-----+---+++++++++++++++++++++++++             
				 #-----#--------+#     #+   ####++++----+-+--+++++++++-++++++++++++++++             
				 #+-+++-------++#   #+--+#+#+++++####+-#----+-+++++---+++++++++#+++++              
				 #-+--#----+--+++#  ##-----#   #-###+##-#---####++++++--++++#####++++#              
				 #--+++---------+###+++++---#+-+##+##-#++##+#++##-++++--+--+######++#               
				##-+--+#----+-+-+####+---+---#-+#++###+--.--+++##+-+-++-+-----#+##+                 
				 #-+++-+----++--+####-----+--+----+++-+------+++---+++#-+-----+---+#           ###  
				  #+-+-+---+--+-----------++----------------+-----+--+#-+-------+--+        #+++#   
				  #+---+------#+------+#+-+++-+##-----++--+--+---+++-##-+----+##+--++       #++#    
#                  +-----+-+---#+------+####-++-+-+------#-.--+--+----#--+-######+--+#     ###+-+#   
				  #++-+-----+++-+----++###+-++-#---+++--+..---++-----#-++--+####+--+-+#####--++-+#  
				   ###+-----++----++--------++-#------+++-.+-+---------+----------+---+##++++++--#  
				   #++------+-#-+---+--+-+---+++--------#+--+-------#-+-+#-----------------------#  
				   #++------+-++-+--+++++---++++++------#+.-#-----++++--+---++-++-+--------------#  
				  ##---+----+--#+++++--#-++#+####-------#-+-+------#+###+----++#--++++----++++###   
				  ##-+--+-#----+++-++++#########+------+-----#-----########+-++#++##########        
					#+--------++-+--+#+#######+--------##--+##-----+#+#######+++++-+#               
 #                ++++#-------+----+#+##+#+#++++#-------+#---#+-----+#+++#+---+----++#               
 #              +++++++-------+-----++++++++++##+#+--#----+##------++++#++-+--+++--++#               
			 #++++++++--------------++++#+++##++#++++-+---++---++-+#+++#+--++#++-++###              
			#+++++++++++----+-----#-++++++++++++#--+----+-+-#+#---+++#+-----+-#+----+##             
		  #++++++++++++++--++#+----+++++++++++#+---------+--+------++#--------+------#              
		 #+++++++++++++++++++++++++++++++++###+---------+------+++-+#--------++++--+-#              
	   ##++++++++++++++++++++++++++++++++++++###++---+#+--------+#+-+--------++----+-#              
	   #+++++++++#++++++++++++++++++++++++############---+----+--#+---------+#-----+-#              
	  #++ ++++++++++++++++++++++++++++++++++########+###+##########-+-------+#+-+--++#              
	  ## #+++++++++++++++++++++++++++++++++#+#######+##############..+-----++##+------              
		#+++++++++++++++++++++++++++++++###+#######################-..#+-+#-+#-+------              
	   #+++++++++++++++++++++++++++++#+++## ########################-..++#-++#-#+-----              
	  #++++++++++++++++++++++++++++++###   ##++---+##################+-+++--#-+------              
	#+++++++++++++++++++++++++##++++#### #+----------################---+#####+------+  
			
# Hello uh...this is my main code body below, everything above is the variables
# Note to any code seekers, Hi let me introduce you to my emotional support letter "A"




func process_extra(extra):
	.process_extra(extra)
	if extra.has("Reduce"):
		reducebutton = extra.Reduce

func tween_camera_zoom(initial_value, end_value, duration, transition_type, ease_type):
	if is_ghost or ReplayManager.resimulating:
		return 
	var game = Global.current_game
	
	emit_signal("zoom_changed")
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
	
func set_camera_zoom(value):
	if is_ghost or ReplayManager.resimulating:
		return 
	if tween:
		tween.kill()
	var game = Global.current_game
	game.camera_zoom = value
	emit_signal("zoom_changed")
	game.update_camera_limits()

func getOpponentName():
	var name = find_parent("Main").match_data.selected_characters[opponent.id]["name"]
	var filter = name.rfind("__") 
	if filter != -1:
		filter += 2
		name = name.right(filter)
	return name



func is_Special():
	if not Network.multiplayer_active and not SteamLobby.SPECTATING:
		var username = Network.pid_to_username(id)
		return username in special
	return false

func is_fight_Catbox():
	if not Network.multiplayer_active and not SteamLobby.SPECTATING:
		var user = Network.pid_to_username(opponent.id)
		return user == "Catbox"
	return false


func Yharim():
	if not Network.multiplayer_active and not SteamLobby.SPECTATING:
		var user = Network.pid_to_username(id)
		return user == "Yharim"
	return false

func apply_style(style):
	.apply_style(style)
	if style != null:
		if options_applied == false:
			options_applied = true
			AchSkin = style.get("AchSkin", false)
	if style.AchNumbNorm >= 12:
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.unlock_achievement(self, "All")
	if style.AchNumbSp >= 3 and style.AchNumbNorm >= 13:
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.unlock_achievement(self, "AllX")
# Skin Names for Exclusive skins and extra
# and yes, if you did this for the skin name, you name a style "LORDE"
	if style != null and !is_ghost and style.style_name == "LORDE": 
		$Flip/Sprite.visible = false
		lordeskin.visible = true
		LORDE = true
		beam.title = "Duck Slaying Squeak"
	if style != null and !is_ghost and style.style_name == "AuricStorm" and is_Special():
		SKIN = true 
	if style != null and !is_ghost and style.style_name == "touhou" and is_Special():
		touhou = true

func on_got_blocked():
	.on_got_blocked()
	if not install and charge < 3 and not GSP:
		charge += 1
	if install and not GSP:
		charge += 1

func spawn_particle_effect(particle_effect:PackedScene, pos:Vector2, dir = Vector2.RIGHT):
	if particle_effect == default_parry:
		particle_effect = custom_parry
	.spawn_particle_effect(particle_effect, pos, dir)

func tick():
	.tick()
	if id == 2 and not Network.multiplayer_active and Yharim():
		AchSkin = true
	if LORDE:
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.unlock_achievement(self, "LORDE?")
	# Limiters and drain for the lightning spawn timer
	if snap > 48:
		snap = 48
	if snap > 0:
		snap -= 1
	if snap < 0:
		snap = 0
	# This is for the player extra, his Reduce for his lightning
	if turn_frames == 1:
		if reducebutton:
			snap -= 24
			charge -= 1
	# Lorde Death SFX
	if hp == 0 and lordeskin.visible and not lorde:
		play_sound("LORDEDEATH")
		lorde = true
	# Cosmetic lightning for when install happens
	if install and not SKIN and not is_ghost:
		red.visible = true
	if install and SKIN and not is_ghost:
		sp.visible = true
	if install and AchSkin and not SKIN and not LORDE:
			ACH.visible = true

		
	# this is for move cooldowns
	if timer:
		time -= 1
	if time == 0:
		timer = false
		time = 40
	if time < 40 and timer == false:
		time = 40
	# this is the limiters for charge and overcharge and how to gain Overcharge
	if infinite_resources:
		charge += 1
		Crystal = false
		Overcharge = false
	if extremely_turbo_mode:
		Crystal = false
		Overcharge = false
	if not install and charge >= 3:
		charge = 3
	if install and charge > 5:
		charge = 5
	if charge == 5 and not Overcharge and over < 1:
		Overcharge = true
		over = 1
		play_sound("OverChargeFull")
	if install and charge >= 5 and Overcharge:
		charge = 5
	if charge < 5 and Overcharge and not OCT:
		Overcharge = false
	# small install buffs
	if install:
		max_ground_speed = "18"
		damage_taken_modifier = "0.8"
	# how you get charges from guard breaks
	if opponent.guard_broken_this_turn and not charged_this_turn:
		charge += 1
		charged_this_turn = true
	if charged_this_turn and not opponent.guard_broken_this_turn:
		charged_this_turn = false
	# Code for how the overcharge Drains
	if OCT:
		CT -= 1
	if CT == 0:
		OCT = false
		CT = 300
		Overcharge = false
	# Achievement stuff
	if visible_combo_count >= 15:
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.unlock_achievement(self, "combo15", true)
	if visible_combo_count >= 25:
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.unlock_achievement(self, "Combo25", true)
	if win == false and opponent.hp <= 0:
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.increment_counter(self, "Win", 1, true)
			if codex_lib.achievement_target_met(self, "Win10"):
				codex_lib.unlock_achievement(self, "Win10", true)
			if codex_lib.achievement_target_met(self, "Win20"):
				codex_lib.unlock_achievement(self, "Win20", true)
			if codex_lib.achievement_target_met(self, "Win50"):
				codex_lib.unlock_achievement(self, "Win50", true)
			win = true
	if opponent.hp == 0 and not AchFail:
		var codex_lib = get_node_or_null("/root/CharCodexLibrary")
		if is_instance_valid(codex_lib):
			codex_lib.unlock_achievement(self, "Auric", true)
	# How you get charges
func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	neu = true
	if obj == opponent and visible_combo_count in combo_thresholds:
		charge += 1
	
