extends CharacterBody2D
var facing_angle : float = 0
var player : CharacterBody2D
@onready var spawn_timer = $Timer
@onready var gun_component = $GunComponent
var direction = 1

func _physics_process(delta):
	if player != null:
		facing_angle = (player.position - position).angle()
		
	if is_instance_valid(player):
		gun_component.fire()
		
	velocity = Vector2.LEFT * 100
	move_and_slide()
