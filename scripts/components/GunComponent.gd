class_name GunComponent
extends Node2D

@onready var fire_rate_timer = $FireRateTimer

@export var fire_rate : float = 1
@export var damage: float = 10
@export var proj_speed : float = 5
#@export var sprite_path: String
#@export var sprite_index : int = 0
@export var parent : CharacterBody2D
@export var projectile_name : String

var n_speed
var direction : Vector2
var effect : Effect
var counter = 0


signal Fired

func _ready():
	effect = Effect.new()
	effect.health_mod = damage
	fire_rate_timer.wait_time = fire_rate

func _process(_delta):
	n_speed = proj_speed
	if parent != null:
		direction = Vector2.from_angle(parent.facing_angle)
		pass
func fire():
	if fire_rate_timer.is_stopped():
		Fired.emit(self)
		fire_rate_timer.start()
