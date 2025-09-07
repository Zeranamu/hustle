extends CharacterState

#	VERSION V1.1, CREATED 31/05/2023 (dd/mm/yy)
#	BY NOK / NOQ

#	/	-------------------------------------------------------------------------------------------------------------
#	INTRODUCTION

#	Hello! This is a drag script created by Nok / Noq, using methods inspired by people like Lam, Nui and Skuz. I
#	didn't invent this method of drag, I just compiled it into a script for ease of access.

# 	If you want a move to do drag, let it extend from this script instead of CharacterState.
#	e.g.

#		extends "res://CoolCharacter/characters/CoolCharacter/DragScriptNok.gd"	

#	like this, or wherever you placed the script. You can right-click the script and press "Copy Path" to get the
#	location of the script.

#	/	-------------------------------------------------------------------------------------------------------------
#	NOTES

#	If you have any scripts that extend from this script, you have to be careful when using "func _tick()" or
#	"func _on_hit_something()". They have to call back to this original script, or they may not work as intended.

#	e.g.

#		func _enter():
#			._enter()

#			<do stuff here>

#		func _tick():
#			._tick()

#			<do stuff here>

#		func _on_hit_something(obj, hitbox):
#			._on_hit_something(obj, hitbox)

#			<do stuff here>

#	However this only applies for the functions above, so any others will work fine.

#	/	-------------------------------------------------------------------------------------------------------------
#	HOW TO USE

#	Now, a quick runthrough of what these values mean.

#		drag								; Toggles whether drag is applied or not.
#		offset_x							; Changes the horizontal offset of where the drag is targeted to.
#		offset_y							; Changes the vertical offset of where the drag is targeted to.
#		end_on_tick							; The drag script will deactivate past this frame.
#		drag_strength						; How powerful the drag is.

#	/	-------------------------------------------------------------------------------------------------------------

export var _c_drag = 0
export (bool) var drag = false
export (int) var offset_x = 0
export (int) var offset_y = 0
export (int) var end_on_tick = 1
export (int) var drag_strength = 10

#	--	Everything below is the actual script. Probably don't tinker with it unless you know what it means.

var hit_opponent = false

func _enter():
	._enter()
	hit_opponent = false

func _tick():
	._tick()
	
	if hit_opponent == true:
		if current_tick < end_on_tick:
			var pos = host.get_pos()
			var opos = host.opponent.get_pos()
			
			host.opponent.set_vel(0, 0)
			host.opponent.move_directly(str((pos.x + (offset_x * host.get_facing_int()) - opos.x) / drag_strength), str((pos.y - (offset_y + 18) - opos.y) / drag_strength))

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	
	if current_tick < end_on_tick:
		if obj == host.opponent:
			hit_opponent = true

#	/	-------------------------------------------------------------------------------------------------------------
#	Miscellaneous super-related stuff.
#	/	-------------------------------------------------------------------------------------------------------------

export  var _c_Super = 0
export var is_super = false
export  var super_level = 0
export  var supers_used = 0
export  var super_freeze_ticks = 15
export  var super_effect = false

func is_usable():
	return .is_usable() and host.supers_available >= super_level

func _frame_0_shared():
	if is_super:
		host.combo_supers += 1
	if super_effect:
		host.super_effect(super_freeze_ticks)
	for i in range(super_level if supers_used == - 1 else supers_used):
		host.use_super_bar()

