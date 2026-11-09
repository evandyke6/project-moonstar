extends Node2D
@export var player:CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_child(0).text = player.state_machine.current_state.to_string()
	get_child(0).text += "\n"
	get_child(0).text += str(player.input_controller.direction)
