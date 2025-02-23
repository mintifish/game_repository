extends PlayerState

@export var run_state: PlayerState


func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO

func process_input(event: InputEvent) -> PlayerState:
	parent.player_direction = Vector2.ZERO
	parent.player_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return null

func process_physics(delta: float) -> PlayerState: #Player animations
	if parent.player_last_direction.x < 0 or parent.player_last_direction.x > 0:
		parent.animations.play("side_idle")
	elif parent.player_last_direction.y < 0:
		parent.animations.play("back_idle")
	elif parent.player_last_direction.y > 0:
		parent.animations.play("front_idle")
	
	if parent.player_direction != Vector2.ZERO: #Plyer is moving and direction not 0
		return run_state
		
	Global.player_position = parent.position
	
	parent.move_and_slide()
	return null
