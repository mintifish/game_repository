extends Node

@export var starting_state: BaseEnemyState
var current_state: BaseEnemyState
@onready var death_state: BaseEnemyState = $death  # Ensure the death state exists

func init(parent: BaseEnemy) -> void:
	for child in get_children():
		child.parent = parent
	
	if parent.has_signal("clear_enemys"):
		parent.clear_enemys.connect(_on_clear_enemys)

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

func _on_clear_enemys():
	change_state(death_state)
