extends BaseEnemyState

@export var run_state: BaseEnemyState


func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO
	parent.animations.play("front_idle")

func process_physics(delta: float) -> BaseEnemyState: #Player animations
	
	if parent.position.distance_to(Vector2.ZERO) > 0:
		parent.position = parent.position - Vector2.ZERO
	
	parent.move_and_slide()
	return null
