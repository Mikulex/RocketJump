extends Area2D

func _on_area_entered(area: Area2D) -> void:
	var direction: Vector2 = area.direction
	
	area.direction = direction.bounce(Vector2(0, -1).rotated(deg_to_rad(rotation_degrees)))
