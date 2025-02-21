extends State

@export var run_state: State


func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO

func process_input(event: InputEvent) -> State:
	Global.direction = Vector2.ZERO
	Global.direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return null

func process_physics(delta: float) -> State: #Player animations
	if Global.last_direction.x < 0 or Global.last_direction.x > 0:
		parent.animations.play("side_idle")
	elif Global.last_direction.y < 0:
		parent.animations.play("back_idle")
	elif Global.last_direction.y > 0:
		parent.animations.play("front_idle")
	
	parent.velocity = Global.direction.normalized() * speed #Velocity update
	
	if parent.velocity != Vector2.ZERO or Global.direction != Vector2.ZERO: #Plyer is moving and direction not 0
		return run_state
	
	parent.move_and_slide()
	return null
