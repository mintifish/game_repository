extends TileMapLayer

@onready var bridge_collision: Area2D = $BridgeCollison
@onready var main_collision = $"../../Ysorting/player"



func _on_bridge_collison_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		main_collision.set_collision_layer_value(2, true)
		main_collision.set_collision_layer_value(3,false)
		main_collision.set_collision_mask_value(2, true)
		main_collision.set_collision_mask_value(3,false)
		Global.clear_enemys.emit()

func _on_bridge_collison_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		main_collision.set_collision_layer_value(3, true)
		main_collision.set_collision_layer_value(2,false)
		main_collision.set_collision_mask_value(3, true)
		main_collision.set_collision_mask_value(2,false)
