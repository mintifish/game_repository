class_name BaseEnemy
extends CharacterBody2D

@export var stats: EnemyResource

@onready var state_machine = $state_machine
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D  # Use AnimatedSprite2D
@onready var collision: CollisionShape2D = $collision
@onready var hitbox_collision: CollisionShape2D = $Hitbox/CollisionShape2D

var speed: float
var attack_damage: float
var acceleration: float

var alive = true

func _ready() -> void:
	speed = stats.speed
	attack_damage = stats.attack_damage
	acceleration = stats.acceleration
	animated_sprite.sprite_frames = stats.sprite_frames  
	animated_sprite.scale = stats.scale
	collision.scale = stats.scale * 1.2
	hitbox_collision.scale = stats.scale * 1.2
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
