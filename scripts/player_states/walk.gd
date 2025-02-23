extends PlayerState

@export var idle_state: PlayerState
@export var run_state: PlayerState


func process_input(event: InputEvent) -> PlayerState:
	parent.player_last_direction = parent.player_direction
	parent.player_direction = Vector2.ZERO
	parent.player_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return null

func process_physics(delta: float) -> PlayerState: #Player animations
	if parent.player_direction.x < 0 or parent.player_direction.x > 0:
		parent.animations.flip_h = parent.player_direction.x < 0
		parent.animations.play("side_walk")
	elif parent.player_direction.y < 0:
		parent.animations.play("back_walk")
	elif parent.player_direction.y > 0:
		parent.animations.play("front_walk")
	
	parent.velocity = parent.player_direction.normalized() * speed
	Global.player_position = parent.position
	
	if parent.velocity == Vector2.ZERO: #Standing Still
		return idle_state
		
	if Input.is_action_just_released("walk"): #Not pressing walk
		return run_state
	
	parent.move_and_slide()
	return null
