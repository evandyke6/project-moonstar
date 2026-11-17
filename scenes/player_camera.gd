extends Marker3D

@export var player : Player
@export var camera : Camera3D
@export var rolling_strength = 1.0
var rotation_y

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _physics_process(delta: float) -> void:
	if player.state_machine.current_state == player.state_machine.get_state("movestate"):
		if player.input_controller.raw_direction == Vector3.LEFT || player.input_controller.raw_direction == Vector3.RIGHT:
			camera.rotation.z = lerp(camera.rotation.z,deg_to_rad(-8 * player.input_controller.raw_direction.x * rolling_strength),0.1 * delta)
			
		if player.input_controller.raw_direction == Vector3.FORWARD|| player.input_controller.raw_direction == Vector3.BACK:
			camera.rotation.x = lerp(camera.rotation.x,deg_to_rad(1 * player.input_controller.raw_direction.z * rolling_strength),0.05 * delta)
	if player.state_machine.current_state == player.state_machine.get_state("idlestate"):
			camera.rotation.z = lerp(camera.rotation.z, 0.0 ,0.1 * delta)
			camera.rotation.x = lerp(camera.rotation.x, 0.0 ,0.05 * delta)
			
	rotate_x(player.input_controller.v_mouse_rotation)
	rotation.x = clampf(rotation.x, -deg_to_rad(70), deg_to_rad(70))
