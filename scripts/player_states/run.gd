extends PlayerState

@export var idle_state: PlayerState
@export var walk_state: PlayerState


func process_input(event: InputEvent) -> PlayerState:
	Global.last_direction = Global.direction
	Global.direction = Vector2.ZERO
	Global.direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return null

func process_physics(delta: float) -> PlayerState: #Player animations
	if Global.direction.x < 0 or Global.direction.x > 0:
		parent.animations.flip_h = Global.direction.x < 0
		parent.animations.play("side_run")
	elif Global.direction.y < 0:
		parent.animations.play("back_run")
	elif Global.direction.y > 0:
		parent.animations.play("front_run")
	
	parent.velocity = Global.direction.normalized() * speed
	
	if parent.velocity == Vector2.ZERO: #Standing Still
		return idle_state
		
	if Input.is_action_pressed("walk"): #Not pressing walk
		return walk_state
	
	parent.move_and_slide()
	return null
