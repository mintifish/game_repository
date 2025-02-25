extends BaseEnemyState

@export var wander_state: BaseEnemyState
@export var chase_state: BaseEnemyState
@onready var timer = $Timer


func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO
	timer.start()
	parent.animated_sprite.play(current_animation)
	return_state = ""

func process_physics(delta: float) -> BaseEnemyState:
	match return_state:
		"wander_state":
			return wander_state
		"chase_state":
			return chase_state
	parent.animated_sprite.play("front_idle")

	parent.move_and_slide()
	return null


func _on_timer_timeout():
	return_state = "wander_state"
