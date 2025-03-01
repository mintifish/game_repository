extends BaseEnemyState

@export var chase_state: BaseEnemyState
@export var death_state: BaseEnemyState

var knockback_direction: Vector2

func enter():
	parent.velocity = Vector2.ZERO
	
	parent.animated_sprite.play(current_animation)
	
	parent.current_hp -= Weapon.weapon_damage_strenght
	parent.health_bar.visible = true
	update_health_bar()

	knockback_direction = (Global.player_position - parent.position).normalized()
	parent.velocity = -knockback_direction * Weapon.knockback_strength
	
	
func process_physics(delta: float) -> BaseEnemyState:
	parent.velocity = Vector2(
		move_toward(parent.velocity.x, -knockback_direction.x * Weapon.knockback_strength, parent.acceleration * delta),
		move_toward(parent.velocity.y, -knockback_direction.y * Weapon.knockback_strength, parent.acceleration * delta))
		
	if parent.current_hp <= 0:
		return death_state
		
	if not parent.animated_sprite.is_playing():
		return chase_state
		
	parent.move_and_slide()
	return null

func update_health_bar():
	if parent.health_bar.value != parent.current_hp:
		parent.health_bar.value = parent.current_hp
