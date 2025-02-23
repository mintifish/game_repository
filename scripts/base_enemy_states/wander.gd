extends BaseEnemyState

@export var idle_state: BaseEnemyState
@export var chase_state: BaseEnemyState
@onready var timer = $Timer
var direction =  Vector2.ZERO


func enter() -> void:
	super()
	parent.animations.play(current_animation)
	direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	timer.start()
	return_state = ""

func process_physics(delta: float) -> BaseEnemyState:
	match return_state:
		"idle_state":
			return idle_state
		"chase_state":
			return chase_state

	parent.velocity = Vector2(
		move_toward(parent.velocity.x, direction.x * speed, acceleration * delta),
		move_toward(parent.velocity.y, direction.y * speed, acceleration * delta))
		
	parent.move_and_slide()
	return null


func _on_view_area_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		return_state = "chase_state"

func _on_timer_timeout():
	return_state = "idle_state"
