class_name BaseEnemy
extends CharacterBody2D

@export var stats: EnemyResource

@onready var state_machine = $state_machine
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D  # Use AnimatedSprite2D
@onready var collision: CollisionShape2D = $collision
@onready var hitbox_collision: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var health_bar: TextureProgressBar = $TextureProgressBar

var speed: float
var attack_damage: float
var acceleration: float
var max_hp: float
var current_hp: float

var alive = true

func _ready() -> void:
	speed = stats.speed
	attack_damage = stats.attack_damage
	acceleration = stats.acceleration
	
	max_hp = stats.max_hp
	current_hp = stats.max_hp
	health_bar.max_value = stats.max_hp
	health_bar.value = stats.max_hp
	
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

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Weapon") and Global.weapon_attack_ip:
		current_hp -= Global.weapon_damage_strenght
		health_bar.visible = true
		update_health_bar()

func update_health_bar():
	if current_hp <= 0:
		queue_free()
	else:
		if health_bar.value != current_hp:
			health_bar.value = current_hp
