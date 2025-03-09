extends PlayerState

@export var idle_state: PlayerState
@export var run_state: PlayerState
@export var attack_state: PlayerState


func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_just_pressed("left_click"):
		return attack_state
	if Input.is_action_just_released("walk"): #Not pressing walk
		return run_state

	parent.player_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return null

func process_physics(delta: float) -> PlayerState: #Player animations
	handle_animations()

	parent.velocity = Vector2(
 	   move_toward(parent.velocity.x, parent.player_direction.x * speed, acceleration * delta),
 	   move_toward(parent.velocity.y, parent.player_direction.y * speed, acceleration * delta)
	)

	if parent.velocity == Vector2.ZERO: #Standing Still
		return idle_state

	parent.move_and_slide()
	return null

func handle_animations():
	if parent.animation_direction.x != 0:
		parent.animations.flip_h = parent.animation_direction.x < 0
		parent.animations.play("side_walk")
	elif parent.animation_direction.y > 0:
		parent.animations.play("front_walk")
	else:
		parent.animations.play("back_walk")
