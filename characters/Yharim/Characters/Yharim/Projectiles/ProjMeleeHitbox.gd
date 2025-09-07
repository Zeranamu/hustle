tool
extends Hitbox

export var perfectParryable = true #Optionally make this un(perfect)parriable.
export var useProjectileParryWindow = false #Dictates if you can parry the projectile with correct spacing. Otherwise, you have to parry the correct frame.
export var alwaysParryable = false

func hit(obj): #override the function that makes us hit stuff to account for normal attack invincibility (IE dodging/rolls)
	if obj is Fighter && obj.invulnerable: #If they're invincible...
		return #abort!
	
	var theirState = obj.state_machine.state
	if obj is Fighter and theirState is ParryState: #parry specific adjustments
		if not perfectParryable:
			theirState.can_parry = false
	
	
	if useProjectileParryWindow && perfectParryable:
		if obj is Fighter && theirState is ParryState:
			var perfect = alwaysParryable || theirState.current_tick <= host.creator.PROJECTILE_PERFECT_PARRY_WINDOW || obj.parried_last_state || obj.always_perfect_parry
			if perfect:
				theirState.can_parry = true
				theirState.perfect = true
				emit_signal("got_parried")
			else:
				theirState.can_parry = false
			obj.block_hitbox(to_data(), perfect)

	
	.hit(obj) #continue as normal.

func to_data(): #when gathering data to show how we hit...
	var normalHitbox = .to_data() #take the default data...
	normalHitbox.host = host.creator.obj_name #and make the user of the hitbox the player instead of the projectile itself!
	return normalHitbox

func _init():
	._init()
	editor_selected = false
