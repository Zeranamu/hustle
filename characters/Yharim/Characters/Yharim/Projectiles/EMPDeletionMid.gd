extends BaseProjectile #//this is a projectiile script

func trigger_consume(obj): #//this function aggressively attempts to delete parriable projectiles
	if obj is BaseProjectile: #//it has a LOT of restrictive conditions to prevent it from deleting things it shouldnt
		var condition = not obj.deletes_other_projectiles #//no idea if these suit your needs or not, but they sure as hell suit mine
		if obj.has_projectile_parry_window:
			condition = true
		if obj.can_be_hit_by_melee:
			condition = false
		if condition:
			var can_state_fizzle = false
			if obj.get("state_machine"):
				if obj.state_machine.get("state"):
					if obj.state_machine.state.has_method("fizzle"):
						can_state_fizzle = true
			
			if can_state_fizzle:
				creator.current_state().enable_hit_cancel()
				obj.state_machine.state.fizzle()
			elif obj.has_method("fizzle"):
				obj.fizzle()
			else:
				obj.disable()
				do_interrupt()
				get_fighter().current_state().enable_interrupt()

func do_interrupt():
	get_fighter().current_state().enable_interrupt()
