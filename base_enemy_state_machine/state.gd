class_name BaseEnemyState
extends Node

@export var current_animation: String

@export var speed: float = 250
@export var acceleration: float = 500

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
