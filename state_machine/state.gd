class_name State
extends Node

@export var current_animation: String

@export var speed: float = 250
@export var acceleration: float = 500

var parent: Player

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
