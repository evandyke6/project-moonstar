extends VisibleOnScreenNotifier2D
@export var parent : CharacterBody2D

func _on_screen_exited():
	parent.queue_free()
