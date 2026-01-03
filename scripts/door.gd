extends Area2D

@export var locked: bool = true
@export var next_scene: PackedScene
@onready var locked_sprite: Sprite2D = $Closed
@onready var unlocked_sprite: Sprite2D = $Open

func _ready() -> void:
	locked_sprite.visible = locked
	unlocked_sprite.visible = not locked

func unlock():
	locked = false
	locked_sprite.visible = false
	unlocked_sprite.visible = true
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not locked:
		get_tree().call_deferred("change_scene_to_packed", next_scene)
