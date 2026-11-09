class_name IdleState

extends State
@export var actor : CharacterBody3D
@export var input : InputController
@export var animated_sprite : AnimatedSprite2D
	 
func physics_update(_delta):
	if input.direction:
		Transitioned.emit(self, "movestate")
		
