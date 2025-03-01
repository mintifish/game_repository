extends BaseEnemyState

@export var wander_state: BaseEnemyState
@export var chase_state: BaseEnemyState
@onready var timer = $Timer


func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO
	parent.animated_sprite.play(current_animation)
	timer.start()
	return_state = ""

func process_physics(delta: float) -> BaseEnemyState:
	match return_state:
		"wander_state":
			return wander_state
		"chase_state":
			return chase_state

	parent.move_and_slide()
	return null

func _on_timer_timeout():
	return_state = "wander_state"

func _on_view_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		return_state = "chase_state"
