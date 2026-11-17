class_name InputController

extends Node

const DIRECTIONS = ["input_right", "input_left", "input_down", "input_up"]
@export var actor : CharacterBody3D
var direction = Vector3.ZERO
var raw_direction = Vector3.ZERO
var total_strength = 0
var rotation = 0
var mouse_sensitivity = 0.007
var v_mouse_rotation = 0.0
var h_mouse_rotation = 0.0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		v_mouse_rotation = -event.screen_relative.y * mouse_sensitivity
		h_mouse_rotation = -event.screen_relative.x * mouse_sensitivity
		
func _process(_delta):
	if v_mouse_rotation == mouse_sensitivity || -mouse_sensitivity:
		v_mouse_rotation = 0
	if h_mouse_rotation == mouse_sensitivity || -mouse_sensitivity:
		h_mouse_rotation = 0
	direction = Vector3.ZERO
	rotation = 0
	
	if Input.is_action_pressed("input_up"):
		direction += Vector3.FORWARD
	if Input.is_action_pressed("input_down"):
		direction += Vector3.BACK
	if Input.is_action_pressed("input_left"):
		direction += Vector3.LEFT
	if Input.is_action_pressed("input_right"):
		direction += Vector3.RIGHT
	if Input.is_action_pressed("input_turnleft"):
		rotation += 1
	if Input.is_action_pressed("input_turnright"):
		rotation += -1
		
		
	raw_direction = direction
	direction = direction.rotated(Vector3.UP,actor.rotation.y)
	direction = direction.normalized()
	
	total_strength = 0
	for dir in DIRECTIONS: # For each direction name  
		total_strength += abs(Input.get_action_strength(dir)) # Get its absolute strength and add to total strength  
	total_strength = min(1, total_strength)
	
	if Input.is_action_pressed("input_slowdown"):
		total_strength *= 0.8

func get_input():
	return [direction, total_strength]
