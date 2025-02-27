class_name Player
extends CharacterBody2D

@onready var animations = $animations
@onready var state_machine = $state_machine

var player_direction: Vector2
var player_last_direction: Vector2
var player_last_velocity: Vector2

@export var weapon_stats: WeaponResource

@onready var weapon_texture = $weapon
@onready var weapon_collision_shape = $weapon/WeaponArea2D/CollisionShape2D
var weapon_damage_deal: float

func _ready() -> void:
	animations.play("front_idle")
	
	weapon_damage_deal = weapon_stats.damage
	weapon_texture.texture = weapon_stats.texture
	weapon_collision_shape.shape = weapon_stats.collision_shape
	
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	Global.player_position = position

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func player():
	pass
