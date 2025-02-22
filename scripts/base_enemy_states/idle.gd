extends BaseEnemyState

@export var wander_state: BaseEnemyState
@export var chase_state: BaseEnemyState
@onready var wander_timer = $Timer


func enter() -> void:
	super()
	parent.animations.play(current_animation)
	
	parent.velocity = Vector2.ZERO
	wander_timer.start()
	return_state = ""

func process_physics(delta: float) -> BaseEnemyState:
	match return_state:
		"wander_state":
			return wander_state
		"chase_state":
			return chase_state
			
	parent.move_and_slide()
	return null


func _on_view_area_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		return_state = "chase_state"

func _on_timer_timeout():
	return_state = "wander_state"
