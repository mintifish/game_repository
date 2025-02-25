extends Resource
class_name EnemyResource

@export var speed: float = 100
@export var attack_damage: float = 20
@export var acceleration: float = 1000
@export var max_hp: float = 100
@export var scale: Vector2 = Vector2(1, 1)

@export var sprite_frames: SpriteFrames  # Store animations instead of a single texture
