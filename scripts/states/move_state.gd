extends State

class_name MoveState
@export var actor : CharacterBody3D
@export var input : InputController
@export var animated_sprite : AnimatedSprite2D

func physics_update(delta):
	#if actor.velocity.length() > 9:
		#animated_sprite.play("run")
	#elif actor.velocity.length() > 3:
		#animated_sprite.play("walk")
	#elif actor.velocity.length() > 0.1:
		#animated_sprite.play("nudge")
	
	actor.velocity += input.direction * actor.acceleration * delta
	
	if input.total_strength > 0.2:
		actor.velocity *= input.total_strength
		
	if !input.direction:
		actor.velocity = actor.velocity * actor.friction
		
	actor.velocity = actor.velocity.limit_length(actor.max_speed)
	actor.move_and_slide()
	
	print(input.direction)
	
	if actor.velocity.length() < 0.1:
		Transitioned.emit(self,"idlestate")
