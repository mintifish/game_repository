class_name Player
extends CharacterBody2D

@onready var animations = $animations
@onready var state_machine = $state_machine
@onready var tool_hitbox = $ToolHitbox

var player_direction: Vector2
var player_last_direction: Vector2

@export var wepon_stats: WeponResource
@onready var wepon_texture = $wepon
var wepon_damage_deal: float

func _ready() -> void:
	animations.play("front_idle")
	
	wepon_damage_deal = wepon_stats.damage
	wepon_texture.texture = wepon_stats.texture
	
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
