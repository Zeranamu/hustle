extends BaseProjectile

var realtick = 0
var hp = -1
var abslife = 0
var icecount = 2
var cname = "null"
var shard = load("res://_LamTyrant/characters/TyShardB.tscn")
var hitter = null
var cooldown1 = 0
var cooldown2 = 0
func _create_speed_after_image(color:Color = Color.white, lifetime = 0.1):
	var speed_image_effect = preload("res://fx/SpeedImageEffect.tscn")
	var texture = sprite.frames.get_frame(sprite.animation, sprite.frame)
	var effect = _spawn_particle_effect(speed_image_effect, get_pos_visual() + sprite.offset)
	effect.set_texture(texture)
	effect.scale.x = $"%Sprite".scale.x * get_facing_int()
	effect.scale.y = $"%Sprite".scale.y
	effect.lifetime = lifetime
	effect.set_color(color)
	effect.sprite.flip_h = get_facing_int() == - 1
	effect.sprite.rotation = sprite.rotation*get_facing_int()
	
func _ready():
	._ready()
	z_as_relative = false
	z_index = 0
	
	
func hit_by(hitbox):
	.hit_by(hitbox)
	
	hitlag_ticks = 1
	
	var pos = get_pos()
	var host = hitbox.host
	var host_object = obj_from_name(host)
	var camera = get_camera()

	if host_object:
		var player_object = host_object.get_owner()
		var player = player_object.obj_name
		if host_object.is_in_group("Fighter"):
			if hitbox.hitbox_type < 3 && host_object.got_parried == false:
				if camera && !is_ghost:
					camera.bump(Vector2(), 10, 8 / 60.0)
					
				if current_state().name == "Scythe" or current_state().name == "Scythe2":
					creator.play_sound("Block2")
					has_projectile_parry_window = true
					always_parriable = true
					if current_state().current_tick < 60:
						current_state().current_tick += 70
						set_vel(0,0)
					
				if current_state().anim_name != "Ici4" && current_state().name == "Idle":
					if host_object == creator:
						host_object.gain_super_meter(50)
					else:
						host_object.gain_super_meter(25)
#				for objs in objs_map.values():
#					if is_instance_valid(objs):
#						if objs.is_in_group("Fighter"):
#							objs.hitlag_ticks = 1
							
				if current_state().name != "Scythe" and current_state().name != "Scythe2":
					current_state().fizzle()
					
				host_object._create_speed_after_image( Color("3ba3ff") , 0.25)
				creator.start_super(8)
				host_object.release_opponent()
				host_object.state_interruptable = true

	if current_state().name == "Idle":
		spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx2.tscn"), Vector2(pos.x,pos.y-22), Vector2(get_facing_int(), 0))
		creator.play_sound("frostbite3")
#		if host_object:
#			var player_object = host_object.get_owner()
#			var player = player_object.obj_name
#			if host_object.is_in_group("Fighter"):
#				var shardA = spawn_object(shard, 0, - 50 - pos.x%15)
#				shardA.creator = creator
#				shardA.creator_name = creator.name
#				shardA.set_vel(0 + host_object.current_di.x/18,-8+ host_object.current_di.y/18)
#				shardA.id = host_object.id
#				var shardB = spawn_object(shard, -16, -25 - pos.x%15)
#				shardB.creator = creator
#				shardB.creator_name = creator.name
#				shardB.set_vel(-5*get_facing_int() + host_object.current_di.x/18,-7 + host_object.current_di.y/18)
#				shardB.id = host_object.id
#				var shardC = spawn_object(shard, 16, -25 - pos.x%15)
#				shardC.creator = creator
#				shardC.creator_name = creator.name
#				shardC.set_vel(5*get_facing_int() + host_object.current_di.x/18,-7 + host_object.current_di.y/18)
#				shardC.id = host_object.id
		
func tick():
	.tick()
	throw_invulnerable = true
	var pos = get_pos()
	var cpos = creator.get_pos()
	var opos = creator.opponent.get_pos()
	var spr_dir = get_facing_int()
	cname = current_state().name
	var opp_hitboxes = creator.opponent.get_active_hitboxes()
	
	if realtick < 1:
		abslife = Global.current_game.current_tick
	
	if cname == "Scythe" or cname == "Scythe2":
		
		if ((creator.current_state().name == "Toss" or creator.current_state().name == "Toss2") && creator.current_state().current_tick <= 2):
			spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx1.tscn"), Vector2(cpos.x,cpos.y - 16), Vector2(get_facing_int(), 0))
			current_state().fizzle()
			
	if cname == "ShardA":
		if realtick < 1:
			sprite.rotation = pos.x
		elif hitlag_ticks == 0:
			sprite.rotation += 0.25
			
		realtick += 1
		
	elif cname == "ShardB":
		if realtick < 1:
			sprite.rotation = pos.x
			realtick += 1
		elif hitlag_ticks == 0:
			sprite.rotation -= 0.1
			
	elif cname == "ShardC":
		sprite.rotation += 0.45
		
	elif cname == "Idle":
		if (creator.current_state().name == "Shatter" or creator.current_state().name == "Shatter2") && creator.current_state().current_tick == 7:
			var shardA = spawn_object(shard, 0, -50 - pos.x%15)
			shardA.creator = creator
			shardA.creator_name = creator.name
			shardA.set_vel(0 + creator.current_di.x/18,-8 + creator.current_di.y/18)
			if current_state().anim_name == "Ici4":
				var shardB = spawn_object(shard, -16, -25 - pos.x%15)
				shardB.creator = creator
				shardB.creator_name = creator.name
				shardB.set_vel(-5*get_facing_int() + creator.current_di.x/18,-7 + creator.current_di.y/18)
				var shardC = spawn_object(shard, 16, -25 - pos.x%15)
				shardC.creator = creator
				shardC.creator_name = creator.name
				shardC.set_vel(5*get_facing_int() + creator.current_di.x/18,-7 + creator.current_di.y/18)
			current_state().fizzle()
			spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyHitFx2.tscn"), Vector2(pos.x,pos.y-22), Vector2(get_facing_int(), 0))
			creator.play_sound("frostbite3")
			
		for objs in objs_map.values():
			if is_instance_valid(objs):
				if objs.creator == creator && objs != self:
					if objs.cname == "Idle" && objs.icecount <= 5:
						if objs.icecount == icecount:
							if objs.abslife > abslife:
								icecount += 1

		if realtick < 1:
			creator.play_sound("icesum")
			spawn_particle_effect(preload("res://_LamTyrant/characters/Assets/Fx/TyShardSumFx.tscn"), Vector2(pos.x,pos.y-6), Vector2(get_facing_int(), 0))
			
			if creator.current_state().name == "Taunt" and current_state().editor_description != "NOTTHRONE":
				current_state().anim_name = "Ici4"
				shard = load("res://_LamTyrant/characters/TyShardB.tscn")
			else:
				if creator.icenum % 3 == 0:
					current_state().anim_name = "Ici1"
				elif creator.icenum % 3 == 1:
					current_state().anim_name = "Ici2"
				elif creator.icenum % 3 == 2:
					current_state().anim_name = "Ici3"
			
			creator.icenum += 1
			
		if realtick == 1:
			sprite.scale.x = 0.6
			sprite.scale.y = 0.6
		elif realtick == 2:
			sprite.scale.x = 0.9
			sprite.scale.y = 0.9
		elif realtick == 3:
			sprite.scale.x = 1.15
			sprite.scale.y = 1.15
		elif realtick == 4:
			sprite.scale.x = 1.1
			sprite.scale.y = 1.1
		elif realtick == 5:
			sprite.scale.x = 1.05
			sprite.scale.y = 1.05
		elif realtick == 6:
			sprite.scale.x = 1
			sprite.scale.y = 1
		realtick += 1
		
		for objs in objs_map.values():
			if is_instance_valid(objs):
				if current_state().anim_name != "Ici4" && current_state().current_tick < 10 && abs(get_pos().x - objs.get_pos().x) < 25 && abs(get_pos().y - objs.get_pos().y) < 25:
					if get_pos().x < objs.get_pos().x:
						move_directly(-1,0)
						objs.move_directly(1,0)
					else:
						if objs.get("abslife"):
							if objs.get("abslife") > abslife:
								move_directly(2,0)
								objs.move_directly(-2,0)
						move_directly(1,0)
						objs.move_directly(-1,0)
	
	
