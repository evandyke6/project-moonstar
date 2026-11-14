class_name Player
extends CharacterBody3D

signal HealthChange

@export var acceleration = 60.0
@export var max_speed = 10.0
@export var friction = .89
@export var animated_sprite : AnimatedSprite2D
@export var input_controller : InputController
@export var state_machine : FSM
@export var weapon : GunComponent
@export var facing_angle : float = 0.0
@export var rotation_speed = 5.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()
func _on_health_component_health_change():
	HealthChange.emit()
