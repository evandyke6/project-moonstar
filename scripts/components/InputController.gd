class_name InputController

extends Node

const DIRECTIONS = ["input_right", "input_left", "input_down", "input_up"]
@export var actor : CharacterBody3D
var direction = Vector3.ZERO
var total_strength = 0

func _process(_delta):
	direction = Vector3.ZERO
	if Input.is_action_pressed("input_up"):
		direction = Vector3.FORWARD
	if Input.is_action_pressed("input_down"):
		direction = Vector3.BACK
	if Input.is_action_pressed("input_left"):
		direction = Vector3.LEFT
	if Input.is_action_pressed("input_right"):
		direction = Vector3.RIGHT
		
	#direction = direction * actor.rotation
	
	total_strength = 0
	for dir in DIRECTIONS: # For each direction name  
		total_strength += abs(Input.get_action_strength(dir)) # Get its absolute strength and add to total strength  
	total_strength = min(1, total_strength)
	
	if Input.is_action_pressed("input_slowdown"):
		total_strength *= 0.8

func get_input():
	return [direction, total_strength]
