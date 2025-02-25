class_name Player
extends CharacterBody2D

@onready var animations = $animations
@onready var state_machine = $state_machine

var player_direction: Vector2
var player_last_direction: Vector2

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	print(Global.player_current_hp)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func player():
	pass
