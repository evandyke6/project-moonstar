class_name IdleState

extends State
@export var actor : CharacterBody3D
@export var input : InputController
@export var animated_sprite : AnimatedSprite2D
	 
func physics_update(delta):
	actor.velocity.x = 0
	actor.velocity.z = 0
	
	if input.rotation:
		actor.rotation.y += actor.rotation_speed * input.rotation * delta
	
	
	if input.direction:
		Transitioned.emit(self, "movestate")
		
