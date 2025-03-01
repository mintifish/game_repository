extends PlayerState

@export var idle_state: PlayerState
@export var run_state: PlayerState

@onready var attack_cooldown_timer = $AttackCooldown

func enter():
	if not attack_cooldown_timer.is_stopped():
		if parent.player_direction == Vector2.ZERO:
			return idle_state
		else:
			return run_state
	else:
		var mouse_pos = parent.get_global_mouse_position() - parent.global_position #mouse position relative to the player
		parent.weapon_animation.rotation = atan2(mouse_pos.y, mouse_pos.x) #rotation degrees relative to mouse position
		
		parent.weapon_animation.play("swipe")
		
		parent.weapon_collision_shape.disabled = false
		parent.weapon_animation.visible = true
		Weapon.weapon_attack_ip = true

func exit():
	parent.weapon_collision_shape.disabled = true
	parent.weapon_animation.visible = false
	Weapon.weapon_attack_ip = false
	if attack_cooldown_timer.is_stopped():
		attack_cooldown_timer.start()

func process_input(event: InputEvent) -> PlayerState:
	parent.player_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return null

func process_physics(delta: float) -> PlayerState:
	handle_animations()
	parent.velocity = Vector2(
		move_toward(parent.velocity.x, parent.player_direction.x * speed, acceleration * delta),
		move_toward(parent.velocity.y, parent.player_direction.y * speed, acceleration * delta))
	
	if not parent.weapon_animation.is_playing(): #
		if parent.player_direction == Vector2.ZERO:
			return idle_state
		else:
			return run_state
	
	parent.move_and_slide()
	return null

func handle_animations():
	if parent.player_direction == Vector2.ZERO:
		if parent.animation_direction.x != 0:
			parent.animations.flip_h = parent.animation_direction.x < 0
			parent.animations.play("side_idle")
		elif parent.animation_direction.y > 0:
			parent.animations.play("front_idle")
		else:
			parent.animations.play("back_idle")
	else:
		if parent.animation_direction.x != 0:
			parent.animations.flip_h = parent.animation_direction.x < 0
			parent.animations.play("side_run")
		elif parent.animation_direction.y > 0:
			parent.animations.play("front_run")
		else:
			parent.animations.play("back_run")
