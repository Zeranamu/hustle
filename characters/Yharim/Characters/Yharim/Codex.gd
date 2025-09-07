extends Node

func register(codex):
	
	codex.moveset["YAuricDash"].desc = "Cost 1 Charge, Free when Tyrant's Might is active"
	codex.moveset["YShoot"].desc = "Cost 1 charge, shoots a projectile"
	codex.moveset["YShootInstall"].desc = "Cost 1 charge and shoots a better projectile, usable when Tyrants might is active"
	codex.moveset["YShootAir"].desc = "Cost 1 charge, shoots a projectile, aerial version"
	codex.moveset["YShootAirInstall"].desc = "Cost 1 charge and shoots a better projectile, usable when Tyrants might is active aerial version"
	codex.moveset["YAuricGutPunch"].desc = "Cost 1 charge 1 bar, has alt version with more vertical reach"
	codex.moveset["YAuricPiston"].desc = "Alt version of Haymaker with more vertical reach, cost 1 charge and bar"
	codex.moveset["YAuricGrab"].desc = "Cost 1 charge and 1 bar, if successfully landed, refunds 1 charge"
	codex.moveset["YAirGrab"].desc = "Cost 1 charge, refunds 1 Charge if successfully landed"
	codex.moveset["YInstall"].desc = "Costs 3 charge and 4 bar, Activates Tyrants might and gives on bar"
	codex.moveset["YOverCharge"].desc = """When you first get 5 bar, you will gain the ability to "Overchagre" costing five bar, if any charges are used while capable of overcharge, you will lose it, this is once per match. Overcharge enhances your specials with lightning strikes"""
	codex.moveset["YGodSlayingPunch"].desc = "Requires Tyrants might to be active, Cost 1 red charge and 1 bar"
	codex.moveset["YAirSpin"].desc = "Cost 1 charge and 2 bar, drags the opponent a slight bit"
	codex.moveset["YRoll"].desc = "A roll with a distance slider, has a alt version with a hitbox on frame 14 and no frame 1 projectile immunity"
	codex.moveset["YCharge"].desc = """Cost 1 bar and gives 1 charge, can only be used once in neutral, requires you to start a combo and exit it to be used again """
	codex.moveset["YSnap"].desc = """Set a delayed lighting projectile, can be sped up for 1 charge, hits 48 ticks after casting, if you hit youself, you gain 1 charge, if you hit a enemies projectile, you cancel your current state and delete the projectile"""
	codex.moveset["YBeam"].desc = "Requires 5 charges and 6 bar"
	codex.moveset["YAurAirKnee"].desc = "Cost 1 charge and 1 bar, has sweetspot, increased mobility with Tyrant's Might"
	codex.moveset["YPalmMid"].desc = "If comes in contact with an enemies projectile, deletes the projectile"
	codex.moveset["YPalmUp"].desc = "If comes in contact with an enemies projectile, deletes the projectile"
	codex.moveset["YImpaleTry"].desc = "Switches sides, has alt version that sends high up and does hard knockdown"
	codex.moveset["YAirFall"].desc = "Yharim spins and falls until he hits the ground, he is not interruptable until he lands or gets hit, has a landing hitbox"
	codex.moveset["Taunt"].desc = "Such a majestic creature"
	codex.moveset["YUAirKick"].visible = false
	codex.set_summary("""Yharim, the Godseeker, also known as Tyrant King Yharim.

Yharim is a rushdown character with brutally strong attacks and block pressure. He has high speed but limited mobility and uses his signature Auric Charge to fuel special options.

Yharim has two installs, Tyrant's Might and Overcharge.
- Tyrant's Might is a permanent buff and makes Auric Dash free. It increases the Auric Charge cap from 3 to 5 and unlocks upgraded versions of other moves such as Auric Orb.
- Overcharge is temporary and adds extra lightning damage to all of his attacks. It can be activated when his Auric Charge meter is at 5/5.
Yharim's weaknesses come from having few defensive tricks, almost no ranged options, and having limited continuous pressure without having Tyrant's Might active.""")

	codex.add_custom_scene_tab("Info & Etc", load("res://Yharim/Characters/Yharim/UI/Codex/YharimInfo.tscn"))
	
func setup_achievements(list):
	list.default_locked_icon = "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments14.png"

	list.set_title("taunt", "Such majestic creatures")
	list.set_desc("taunt", "Admire a majestic creature")
	list.set_icon("taunt", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments1.png")

	list.set_title("OC", "A Dreadful Forecast")
	list.set_desc("OC", """Activate "Overcharge" Once in a match""")
	list.set_icon("OC", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments4.png")

	list.set_title("intimidation", "Tyrannical Intimidation")
	list.set_desc("intimidation", "Get a round 1 perfect parry as Yharim")
	list.set_icon("intimidation", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments3.png")

	list.set_title("Install", "The might to crush a God")
	list.set_desc("Install", """Use "Tyrant's Might" as Yharim""")
	list.set_icon("Install", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments8.png")
	list.define("Install", { "highlight_color": Color("#ffea77") })

	list.set_title("Auric", "Ground and Pound")
	list.set_desc("Auric", """Win a match without using Auric Charge""")
	list.set_icon("Auric", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments19.png")
	list.define("Auric", { "highlight_color": Color("#ffea77") })

	list.set_title("Beam", "Purified")
	list.set_desc("Beam", """Slay an opponent using the God Slaying Beam""")
	list.set_icon("Beam", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments6.png")
	list.define("Beam", { "highlight_color": Color("#ffea77") })

	list.set_title("Devourer", "Essence Devourer")
	list.set_desc("Devourer", """Slay an opponent using the God Slaying Punch""")
	list.set_icon("Devourer", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments18.png")
	list.define("Devourer", { "highlight_color": Color("#ffea77") })

	list.set_title("combo15", "Dragon's Rage")
	list.set_desc("combo15", "Reach A combo count of 15")
	list.set_icon("combo15", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments2.png")

	list.set_title("Combo25", "Unspeakable Brutality")
	list.set_desc("Combo25", "Reach a combo count of 25")
	list.set_icon("Combo25", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments9.png")
	list.define("Combo25", { "highlight_color": Color("#ffea77") })

	list.set_title("Win10", "Meek, Ingratiated Swine")
	list.set_desc("Win10", "Win 10 times as Yharim")
	list.set_icon("Win10", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments5.png")
	list.assign_counter("Win10", "Win", 10)

	list.set_title("Win20", "A Grand Crusade")
	list.set_desc("Win20", "Win 20 times as Yharim")
	list.set_icon("Win20", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments12.png")
	list.define("Win20", { "highlight_color": Color("#ffea77") })
	list.assign_counter("Win20", "Win", 20)

	list.set_title("Win50", "Destiny is for the Weak")
	list.set_desc("Win50", "Win 50 times as Yharim")
	list.set_icon("Win50", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments13.png")
	list.define("Win50", { "highlight_color": Color("#36f6ff") })
	list.assign_counter("Win50", "Win", 50)

	list.set_title("Catbox", "The one who dared to seek me out")
	list.set_desc("Catbox", "While playing Yharim, have a match with Yharim Developer, Catbox")
	list.set_icon("Catbox", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments10.png")
	list.define("Catbox", { "highlight_color": Color("#ffea77") })
	list.mark_secret("Catbox")

	list.set_title("LORDE?", "Como toda la sangre se derrite en la lluvia")
	list.set_desc("LORDE?", "Use the LORDE skin")
	list.set_icon("LORDE?", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments11.png")
	list.define("LORDE?", { "highlight_color": Color("#ffea77") })
	list.mark_secret("LORDE?")

	list.set_title("Dreadon", "Draedon...")
	list.set_desc("Dreadon", """Fight one of your clones 
	(Yharim or Syrim)""")
	list.set_icon("Dreadon", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments7.png")
	list.define("Dreadon", { "highlight_color": Color("#ffea77") })
	list.mark_secret("Dreadon")

	list.set_title("All", "A Worthy Cause")
	list.set_desc("All", "Unlock all non secret achievements.")
	list.set_icon("All", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments20.png")
	list.define("All", { "highlight_color": Color("#ff0000") })

	list.set_title("AllX", "Cynosure")
	list.set_desc("AllX", "Unlock all achievements, including secret ones.")
	list.set_icon("AllX", "res://Yharim/Characters/Yharim/Icons/Achievement Icons/YharimAchivments21.png")
	list.define("AllX", { "highlight_color": Color("#ff0000") })
	list.mark_secret("AllX")

func modify_style_data(style, params):
	var codex_lib = params.codex_library
	var char_path = params.char_path
	var achievements = codex_lib.get_achievement_list(char_path)
	var totals = achievements.get_totals()
	var options_data = codex_lib.load_all_char_options(char_path)

	style.AchSkin = options_data.get("AchSkin")
	style.AchNumbNorm = totals.unlocked_visible
	style.AchNumbSp = totals.unlocked_secret

func setup_options(options, params):
	options.add_label("When you get all achievements, you will unlock the option to use his Aura")
	var codex_lib = params.codex_library
	var char_path = params.char_path
	var achievements = codex_lib.get_achievement_list(char_path)
	var totals = achievements.get_totals()
	
	if totals.unlocked_visible >= 12:
		options.add_toggle("AchSkin", "Use Achievement Aura")
		options.add_label("Toggle to use Yharim's aura (will cancel if other aura is used)")


