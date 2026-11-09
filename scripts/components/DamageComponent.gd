extends Area2D
var effect : Effect

@export var health_mod : int
signal Hit

func _ready():
	effect = Effect.new()
	effect.health_mod = health_mod

func _on_hurtbox_entered(area):
	if area is HurtboxComponent:
		var hurtbox : HurtboxComponent = area
		hurtbox.damage(effect.health_mod)
		Hit.emit()
