extends BaseEnemyState

@export var idle_state: BaseEnemyState
@export var attack_state: BaseEnemyState
var move_to_player = true

func enter():
	parent.animations.play(current_animation)
	move_to_player = true
	return_state = ""

func process_physics(delta: float) -> BaseEnemyState:
	match return_state:
		"idle_state":
			return idle_state

	if move_to_player: 
		parent.velocity = Global.player_position - parent.position
	else:
		return attack_state

	parent.move_and_slide()
	return null


func _on_view_area_body_exited(body: Node2D): #Player exited view zone
	if body.is_in_group("Player"):
		return_state = "idle_state"

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		move_to_player = false

func _on_hitbox_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		move_to_player = true
