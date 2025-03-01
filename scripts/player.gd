class_name Player
extends CharacterBody2D

@onready var animations = $animations
@onready var state_machine = $state_machine
@onready var health_bar = $HealthBar

@onready var regen_timer = $RegenTimer
var regen_speed: float = 0.1 
var is_regenerating: bool = false

var player_direction: Vector2
var animation_direction: Vector2

@export var weapon_stats: WeaponResource
@onready var weapon_animation = $Weapon
@onready var weapon_collision_shape = $Weapon/WeaponArea2D/CollisionShape2D

func _ready() -> void:
	animations.play("front_idle")

	Global.weapon_damage_strenght = weapon_stats.damage_strenght
	weapon_animation.sprite_frames = weapon_stats.sprite_frames
	weapon_collision_shape.shape = weapon_stats.collision_shape
	
	Global.player_taken_damage.connect(_on_player_taken_damage)
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	if player_direction != Vector2.ZERO:
		animation_direction = player_direction
	state_machine.process_physics(delta)
	Global.player_position = position
	update_health_bar()

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func update_health_bar():
	if health_bar.value != Global.player_current_hp:
		health_bar.value = Global.player_current_hp
		
	if is_regenerating == false and Global.player_current_hp < Global.player_max_hp and regen_timer.is_stopped():
		regen_timer.start()
	
	if is_regenerating:
		Global.player_current_hp += regen_speed
		if Global.player_current_hp >= Global.player_max_hp:
			is_regenerating = false
			Global.player_current_hp = Global.player_max_hp
	
func _on_regen_timer_timeout() -> void:
	is_regenerating = true

func _on_player_taken_damage():
	is_regenerating = false
