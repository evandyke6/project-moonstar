extends State

class_name MoveState
@export var actor : CharacterBody3D
@export var input : InputController
@export var animated_sprite : AnimatedSprite2D
var horizontal_velocity = Vector2.ZERO

func physics_update(delta):
	#if actor.velocity.length() > 9:
		#animated_sprite.play("run")
	#elif actor.velocity.length() > 3:
		#animated_sprite.play("walk")
	#elif actor.velocity.length() > 0.1:
		#animated_sprite.play("nudge")
	
	if actor.is_on_floor():
		actor.velocity += input.direction * actor.acceleration * delta
	
	if input.total_strength > 0.2:
		actor.velocity *= input.total_strength
		
	if !input.direction && actor.is_on_floor():
		actor.velocity = actor.velocity * actor.friction * delta
		
	if input.rotation:
		actor.rotation.y += actor.rotation_speed * input.rotation * delta
	
	horizontal_velocity = Vector2(actor.velocity.x, actor.velocity.z)
	if horizontal_velocity.length() > actor.max_speed:
		horizontal_velocity = horizontal_velocity.normalized() * actor.max_speed
	
	actor.velocity.x = horizontal_velocity.x
	actor.velocity.z = horizontal_velocity.y
	
	
	if actor.velocity.length() < 0.1:
		Transitioned.emit(self,"idlestate")
