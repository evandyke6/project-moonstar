extends CharacterBody2D
@export var speed : float
@export var direction : Vector2

func _physics_process(_delta):
	velocity = speed * direction
	move_and_slide()
	
func _on_damage_component_hit():
	queue_free()
