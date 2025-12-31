extends Area2D

@export var lock: Node2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		lock.unlock()
	queue_free()
