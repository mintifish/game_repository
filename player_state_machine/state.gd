class_name PlayerState
extends Node

@export var current_animation: String

@export var speed: float = 250
@export var acceleration: float = 1000

var parent: Player

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(event: InputEvent) -> PlayerState:
	return null

func process_frame(delta: float) -> PlayerState:
	return null

func process_physics(delta: float) -> PlayerState:
	return null
