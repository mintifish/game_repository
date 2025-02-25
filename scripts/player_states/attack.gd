extends PlayerState

@export var idle_state: PlayerState
@export var run_state: PlayerState
var attack_finished: bool

func enter():
	attack_finished = false
	handle_attack_animation()

func handle_attack_animation():
	var mouse_pos = parent.get_global_mouse_position()
	var direction = (mouse_pos - parent.global_position).normalized()

	if abs(direction.x) > abs(direction.y):
		# Horizontal attack
		parent.animations.flip_h = direction.x < 0
		parent.animations.play("side_attack_sword_1")
	else:
		# Vertical attack
		if direction.y < 0:
			parent.animations.play("back_attack_sword_1")
		else:
			parent.animations.play("front_attack_sword_1")

func process_input(event: InputEvent) -> PlayerState:
	if parent.player_direction != Vector2.ZERO:
		parent.player_last_direction = parent.player_direction
	parent.player_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return null

func process_physics(delta: float) -> PlayerState:
	parent.velocity = Vector2(
		move_toward(parent.velocity.x, parent.player_direction.x * speed, acceleration * delta),
		move_toward(parent.velocity.y, parent.player_direction.y * speed, acceleration * delta)
	)

	if attack_finished:
		if parent.player_direction == Vector2.ZERO:
			return idle_state
		else:
			return run_state

	parent.move_and_slide()
	return null

func _on_animations_animation_finished() -> void:
	attack_finished = true
