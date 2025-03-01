extends BaseEnemyState


func enter():
	parent.velocity = Vector2.ZERO
	parent.animated_sprite.play(current_animation)

func process_physics(delta: float) -> BaseEnemyState:
	
	if not parent.animated_sprite.is_playing():
		parent.queue_free()
		
	parent.move_and_slide()
	return null
