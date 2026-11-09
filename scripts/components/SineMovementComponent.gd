extends Node2D
@export var parent : CharacterBody2D
@export var amplitude : float
@export var frequency : float
@export var x_offset : float
@export var y_offset : float 

func _physics_process(_delta):
	parent.position.y += amplitude * sin(frequency * (parent.position.x - x_offset)) + y_offset
