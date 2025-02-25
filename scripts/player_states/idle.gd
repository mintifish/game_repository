extends PlayerState

@export var run_state: PlayerState
@export var attack_state: PlayerState


func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_just_pressed("left_click"):
		return attack_state
		
	var new_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if new_direction != Vector2.ZERO:
		parent.player_direction = new_direction

	return null

func process_physics(delta: float) -> PlayerState:
	if parent.player_last_direction.x < 0 or parent.player_last_direction.x > 0:
		parent.animations.flip_h = parent.player_last_direction.x < 0
		parent.animations.play("side_idle")
	elif parent.player_last_direction.y < 0:
		parent.animations.play("back_idle")
	elif parent.player_last_direction.y > 0:
		parent.animations.play("front_idle")
	
	if parent.player_direction != Vector2.ZERO: #Plyer is moving and direction not 0
		return run_state

	parent.move_and_slide()
	return null
