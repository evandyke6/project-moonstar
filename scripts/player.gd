class_name Player
extends CharacterBody3D

signal HealthChange

@export var acceleration = 60
@export var max_speed = 10
@export var friction = .89
@export var animated_sprite : AnimatedSprite2D
@export var input_controller : InputController
@export var state_machine : FSM
@export var weapon : GunComponent
@export var facing_angle : float = 0


func _on_health_component_health_change():
	HealthChange.emit()
