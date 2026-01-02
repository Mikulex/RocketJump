extends Node2D

@export var speed: float = 200
@export var knockback: float = 70

var direction: Vector2
var hit: bool = false

@onready var explosion: Area2D = $Explosion
@onready var explosion_anim: AnimationPlayer = $AnimationPlayer
@onready var bullet_sprite = $BulletSprite

func _process(delta: float) -> void:
	if not hit:
		position += speed * direction * delta
		
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		return
		
	hit = true
	
	for b in explosion.get_overlapping_bodies():
		if b.is_in_group("Player"):
			var dir = global_position.direction_to(b.global_position)
			b.velocity.x += dir.x * knockback
			b.velocity.y += dir.y * knockback
			
	
	_explosion_anim()

func _explosion_anim():
	bullet_sprite.visible = false
	explosion_anim.play("Explosion")
	
func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if _anim_name == "Explosion":
		queue_free()
