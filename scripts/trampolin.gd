extends Area2D

@export var strength: float = 200
@export var push_direction: Vector2 = Vector2(0,-1)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.velocity = push_direction.normalized() * strength
