extends State

@export var idle_state: State
@export var run_state: State


func process_input(event: InputEvent) -> State:
	Global.last_direction = Global.direction
	Global.direction = Vector2.ZERO
	Global.direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return null

func process_physics(delta: float) -> State: #Player animations
	if Global.direction.x < 0 or Global.direction.x > 0:
		parent.animations.flip_h = Global.direction.x < 0
		parent.animations.play("side_walk")
	elif Global.direction.y < 0:
		parent.animations.play("back_walk")
	elif Global.direction.y > 0:
		parent.animations.play("front_walk")
	
	parent.velocity = Global.direction.normalized() * speed
	
	if parent.velocity == Vector2.ZERO: #Standing Still
		return idle_state
		
	if Input.is_action_just_released("walk"): #Not pressing walk
		return run_state
	
	parent.move_and_slide()
	return null
