extends BaseEnemyState

@export var idle_state: BaseEnemyState
@export var attack_state: BaseEnemyState

var move_to_player = true


func enter():
	move_to_player = true
	parent.animated_sprite.play(current_animation)
	return_state = ""

func process_physics(delta: float) -> BaseEnemyState:
	match return_state:
		"idle_state":
			return idle_state
	if move_to_player:
		var direction = (Global.player_position - parent.position).normalized()
		parent.velocity = Vector2(
			move_toward(parent.velocity.x, direction.x * parent.speed, parent.acceleration * delta),
			move_toward(parent.velocity.y, direction.y * parent.speed, parent.acceleration * delta)
		)
	else:
		return attack_state

	parent.move_and_slide()
	return null
