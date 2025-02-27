extends PlayerState

@export var idle_state: PlayerState
@export var run_state: PlayerState

@onready var attack_cooldown_timer = $AttackCooldown
var current_degrees: float
var end_degrees: float
var start_degrees: float
var step_degrees: float
var swing_speed: float = 300


func set_vars(pos: Vector2):
	if abs(pos.x) > abs(pos.y):
		if pos.x > 0:
			start_degrees = -15
			end_degrees = 105
			step_degrees = swing_speed
		else:  # Left
			start_degrees = -75
			end_degrees = -195
			step_degrees = -swing_speed
	else:  # Up or Down movement
		if pos.y > 0:  # Down
			start_degrees = 75
			end_degrees = 195 
			step_degrees = swing_speed
		else:  # Up
			start_degrees = -105
			end_degrees = 15 
			step_degrees = swing_speed

	current_degrees = start_degrees

func enter():
	if not attack_cooldown_timer.is_stopped():
		if parent.player_direction == Vector2.ZERO:
			return idle_state
		else:
			return run_state
	else:
		set_vars(parent.get_global_mouse_position() - parent.global_position)
		parent.weapon_texture.rotation_degrees = current_degrees
		parent.weapon_texture.visible = true
		Global.weapon_attack_ip = true

func exit():
	parent.weapon_texture.visible = false
	Global.weapon_attack_ip = false
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
	
	# Process weapon swing
	if abs(current_degrees - end_degrees) < abs(step_degrees * delta):
		current_degrees = end_degrees
	else:
		current_degrees += step_degrees * delta
	parent.weapon_texture.rotation_degrees = current_degrees
	
	# Transition to different states
	if current_degrees == end_degrees:
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
