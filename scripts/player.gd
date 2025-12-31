extends CharacterBody2D

@export var MAX_SPEED: float = 60
@export var ACCEL: float = 5
@export var BRAKE: float = 5
@export var JUMP_HEIGHT: float = 110
@export var FALL_SPEED: float = 300
@export var SHOOT_RATE: float = 1

@onready var bullet: PackedScene = preload("res://scenes/bullet.tscn")
@onready var hurtbox: Area2D = $HitArea

var cooldown = SHOOT_RATE

func _physics_process(delta: float) -> void:
	var input: float = Input.get_axis("move_left", "move_right")
	if input:
		velocity.x = lerp(velocity.x, input * MAX_SPEED, ACCEL * delta)
	else: 
		velocity.x = lerp(velocity.x, 0.0, BRAKE * delta)
		
	if Input.is_action_pressed("move_up") and is_on_floor(): 
		velocity.y = -JUMP_HEIGHT
	elif not is_on_floor():
		velocity.y += FALL_SPEED * delta
		
	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and cooldown >= SHOOT_RATE:
		var new_bullet = bullet.instantiate()
		new_bullet.direction = global_position.direction_to(get_global_mouse_position())
		new_bullet.position = position
		get_tree().get_current_scene().add_child.call_deferred(new_bullet)
		cooldown = 0
	
	if cooldown < SHOOT_RATE:
		cooldown += delta

func _on_area_2d_body_entered(_body: Node2D) -> void:
	get_tree().reload_current_scene()
