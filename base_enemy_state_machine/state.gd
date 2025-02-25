class_name BaseEnemyState
extends Node

var return_state = ""

@export var current_animation: String

var parent: BaseEnemy

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> BaseEnemyState:
	return null

func process_frame(delta: float) -> BaseEnemyState:
	return null

func process_physics(delta: float) -> BaseEnemyState:
	return null
