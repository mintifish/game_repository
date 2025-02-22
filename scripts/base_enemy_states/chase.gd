extends BaseEnemyState

@export var idle_state: BaseEnemyState


func enter():
	parent.animations.play(current_animation)
	return_state = ""

func process_physics(delta: float) -> BaseEnemyState:
	match return_state:
		"idle_state":
			return idle_state

	if parent.position.distance_to(Global.player_position) > 20: 
		parent.velocity = Global.player_position - parent.position

	parent.move_and_slide()
	return null


func _on_view_area_body_exited(body: Node2D):
	if body.is_in_group("Player"):
		return_state = "idle_state"
