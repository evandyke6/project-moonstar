extends Node
class_name HealthComponent

signal HealthChange

@export var max_health : float = 10
@export var can_die : bool = true
var current_health

func _ready():
	current_health = max_health
	
func modify_health(amount):
	current_health += amount
	if current_health <= 0:
		current_health = 0
		if can_die:
			get_parent().queue_free()
	if current_health > max_health:
		current_health = max_health
	HealthChange.emit()
