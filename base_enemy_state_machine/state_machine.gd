extends Node

@export var starting_state: BaseEnemyState
var current_state: BaseEnemyState

func init(parent: BaseEnemy) -> void:
	for child in get_children():
		child.parent = parent
	change_state(starting_state)

func change_state(new_state: BaseEnemyState) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
		
'''func _on_view_area_body_entered(body: Node2D) -> void: # handles chase on
	if body.is_in_group("Player"):
		change_state($chase)
		
func _on_view_area_body_exited(body: Node2D) -> void: # handles chase off
	if body.is_in_group("Player"):
		change_state($idle)

func _on_hitbox_area_entered(area: Area2D) -> void: # start attack
	if area.is_in_group("Weapon") and Weapon.weapon_attack_ip:
		change_state($hurt)
	elif area.is_in_group("Player"):
		change_state($attack)

func _on_hitbox_area_exited(area: Area2D) -> void: # stop attack		
	if area.is_in_group("Player"):
		change_state($chase)'''
		
