extends BaseEnemyState

@export var idle_state: BaseEnemyState
@export var attack_state: BaseEnemyState
@export var hurt_state: BaseEnemyState


func enter():
	parent.animated_sprite.play(current_animation)
	return_state = ""

func process_physics(delta: float) -> BaseEnemyState:
	match return_state:
		"idle_state":
			return idle_state
		"attack_state":
			return attack_state
		"hurt_state":
			return hurt_state
			
	var direction = Vector2()
	parent.nav_agent.target_position = Global.player_position
	direction = (parent.nav_agent.get_next_path_position() - parent.position).normalized()
	
	
	parent.velocity = Vector2(
		move_toward(parent.velocity.x, direction.x * parent.speed, parent.acceleration * delta),
		move_toward(parent.velocity.y, direction.y * parent.speed, parent.acceleration * delta))

	parent.move_and_slide()
	return null

func _on_view_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		return_state = "idle_state"

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Weapon") and Weapon.weapon_attack_ip:
		return_state = "hurt_state"
		
	elif area.is_in_group("Player"):
		return_state = "attack_state"
