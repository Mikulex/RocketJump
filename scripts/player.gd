extends CharacterBody2D

@export var MAX_SPEED: float = 60
@export var ACCEL: float = 2.5
@export var BRAKE: float = 5
@export var JUMP_HEIGHT: float = 110
@export var FALL_SPEED: float = 300
@export var SHOOT_RATE: float = 1

@onready var bullet: PackedScene = preload("res://scenes/bullet.tscn")
@onready var hurtbox: Area2D = $HitArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite

var cooldown = SHOOT_RATE
var input: float

func _physics_process(delta: float) -> void:
	input = Input.get_axis("move_left", "move_right")
	
	_handle_dash()
	
	if input:
		if velocity.x * input < MAX_SPEED or is_on_floor():
			velocity.x = lerp(velocity.x, input * MAX_SPEED, ACCEL * delta)
	elif is_on_floor(): 
		velocity.x = lerp(velocity.x, 0.0, BRAKE * delta)
		
	if Input.is_action_pressed("move_up") and is_on_floor(): 
		velocity.y = -JUMP_HEIGHT
	elif not is_on_floor():
		velocity.y += FALL_SPEED * delta
		
	move_and_slide()

func _process(delta: float) -> void:
	if not is_on_floor():
		animation_player.play("Jump")
	elif input:
		animation_player.play("Walk")
	else: 
		animation_player.play("Idle")
	
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0
	
	if Input.is_action_pressed("shoot") and cooldown >= SHOOT_RATE:
		var new_bullet = bullet.instantiate()
		new_bullet.direction = global_position.direction_to(get_global_mouse_position())
		new_bullet.position = position
		get_tree().get_current_scene().add_child.call_deferred(new_bullet)
		cooldown = 0
	
	if cooldown < SHOOT_RATE:
		cooldown += delta

func _handle_dash():
	if not Input.is_action_pressed("dash"):
		return
		
	if is_on_floor():
		velocity.y = -JUMP_HEIGHT * 0.5
		
		var dir = 1 if velocity.x >= 0 else -1
		if input != 0:
			dir = input
			
		velocity.x = dir * max(MAX_SPEED * 1.75, abs(velocity.x))

func _on_hit_area_body_entered(_body: Node2D) -> void:
	get_tree().call_deferred("reload_current_scene")
