class_name BaseEnemy
extends CharacterBody2D

@export var stats: EnemyResource

@onready var state_machine = $state_machine
@onready var sprite: Sprite2D = $Sprite2D

var speed: float
var attack_damage: float
var acceleration: float

var alive = true

func _ready() -> void:
	speed = stats.speed
	attack_damage = stats.attack_damage
	acceleration = stats.acceleration
	sprite.texture = stats.texture
	
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
