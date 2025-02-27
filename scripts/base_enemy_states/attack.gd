extends BaseEnemyState

@export var chase_state: BaseEnemyState
var has_dealt_damage: bool = false

func enter():
	parent.animated_sprite.play(current_animation)
	return_state = ""
	has_dealt_damage = false  # Reset the flag on enter

func process_physics(delta: float) -> BaseEnemyState:
	match return_state:
		"chase_state":
			return chase_state

	if parent.animated_sprite.get_frame() == 7 and not has_dealt_damage:
		Global.player_current_hp -= parent.attack_damage
		has_dealt_damage = true

	if parent.animated_sprite.get_frame() != 7:
		has_dealt_damage = false

		
	return null

func _on_hitbox_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		return_state = "chase_state"
