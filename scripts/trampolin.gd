extends Area2D

@export var strength: float = 200

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.velocity.y = min(-strength, body.velocity.y - strength)
