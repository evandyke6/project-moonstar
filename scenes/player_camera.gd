extends Marker3D

@export var player : Player
@export var camera : Camera3D
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
			rotation.z = lerp(rotation.z,deg_to_rad(-2 * player.input_controller.raw_direction.x),0.1)
			
		if player.input_controller.raw_direction == Vector3.FORWARD|| player.input_controller.raw_direction == Vector3.BACK:
			rotation.x = lerp(rotation.x,deg_to_rad(3 * player.input_controller.raw_direction.z),0.05)
	if player.state_machine.current_state == player.state_machine.get_state("idlestate"):
			rotation.z = lerp(rotation.z, 0.0 ,0.1)
			rotation.x = lerp(rotation.x, 0.0 ,0.05)
