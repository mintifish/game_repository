extends PlayerState

@export var idle_state: PlayerState
@export var run_state: PlayerState

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
	set_vars(parent.get_global_mouse_position() - parent.global_position)
	parent.weapon_texture.rotation_degrees = current_degrees
	parent.weapon_texture.visible = true
	Global.weapon_attack_ip = true

func exit():
	parent.weapon_texture.visible = false
	Global.weapon_attack_ip = false
	
func process_input(event: InputEvent) -> PlayerState:
	parent.player_last_direction = parent.player_direction
	parent.player_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return null

func process_physics(delta: float) -> PlayerState:
	parent.player_last_velocity = parent.velocity
	
	parent.velocity = Vector2(
		move_toward(parent.velocity.x, parent.player_direction.x * speed, acceleration * delta),
		move_toward(parent.velocity.y, parent.player_direction.y * speed, acceleration * delta)
	)
	
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
