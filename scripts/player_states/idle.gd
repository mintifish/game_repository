extends PlayerState

@export var run_state: PlayerState


func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO
	parent.animations.play("front_idle")

func process_input(event: InputEvent) -> PlayerState:
	Global.player_direction = Vector2.ZERO
	Global.player_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return null

func process_physics(delta: float) -> PlayerState: #Player animations
	if Global.player_last_direction.x < 0 or Global.player_last_direction.x > 0:
		parent.animations.play("side_idle")
	elif Global.player_last_direction.y < 0:
		parent.animations.play("back_idle")
	elif Global.player_last_direction.y > 0:
		parent.animations.play("front_idle")
	
	parent.velocity = Global.player_direction.normalized() * speed #Velocity update
	Global.player_position = parent.position
	
	if parent.velocity != Vector2.ZERO or Global.player_direction != Vector2.ZERO: #Plyer is moving and direction not 0
		return run_state
	
	parent.move_and_slide()
	return null
