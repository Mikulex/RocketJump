extends StaticBody2D

@export var lock: Node2D

@onready var pressed_sprite: Sprite2D = $Base/Pressed
@onready var unpressed_sprite: Sprite2D = $Base/Unpressed

var pressed: bool = false

func press_button():
	if pressed:
		return
	
	lock.unlock()
	pressed = true
	pressed_sprite.visible = true
	unpressed_sprite.visible = false
		
