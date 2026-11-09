extends Area2D
class_name HurtboxComponent

@export var health_component : HealthComponent

func damage(source):
	if health_component is HealthComponent:
		health_component.modify_health(source)
