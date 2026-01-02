extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var speed_label: Label = $CanvasLayer/Label 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed_label.text = str(player.velocity.x).pad_decimals(2) + ", " + str(player.velocity.y).pad_decimals(2)
