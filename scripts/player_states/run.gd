extends PlayerState

@export var idle_state: PlayerState
@export var walk_state: PlayerState


func process_input(event: InputEvent) -> PlayerState:
	Global.player_last_direction = Global.player_direction
	Global.player_direction = Vector2.ZERO
	Global.player_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return null

func process_physics(delta: float) -> PlayerState: #Player animations
	if Global.player_direction.x < 0 or Global.player_direction.x > 0:
		parent.animations.flip_h = Global.player_direction.x < 0
		parent.animations.play("side_run")
	elif Global.player_direction.y < 0:
		parent.animations.play("back_run")
	elif Global.player_direction.y > 0:
		parent.animations.play("front_run")
	
	parent.velocity = Global.player_direction.normalized() * speed
	Global.player_position = parent.position

	
	if parent.velocity == Vector2.ZERO: #Standing Still
		return idle_state
		
	if Input.is_action_pressed("walk"): #Not pressing walk
		return walk_state
	
	parent.move_and_slide()
	return null
