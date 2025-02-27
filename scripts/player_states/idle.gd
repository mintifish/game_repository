extends PlayerState

@export var run_state: PlayerState
@export var attack_state: PlayerState


func enter():
	parent.velocity = Vector2.ZERO

func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_just_pressed("left_click"):
		return attack_state

	parent.player_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return null

func process_physics(delta: float) -> PlayerState:
	handle_animations()
	
	if parent.player_direction != Vector2.ZERO: #Plyer is moving and direction not 0
		return run_state

	parent.move_and_slide()
	return null

func handle_animations():
	if parent.animation_direction.x != 0:
		parent.animations.flip_h = parent.animation_direction.x < 0
		parent.animations.play("side_idle")
	elif parent.animation_direction.y > 0:
		parent.animations.play("front_idle")
	else:
		parent.animations.play("back_idle")
