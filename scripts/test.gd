extends Node2D

@onready var player = $Player
@onready var label = $CanvasLayer/Label
@onready var label_timer = $CanvasLayer/LabelTimer
@onready var color_rect = $CanvasLayer/ColorRect
@onready var health_component = $Player/HealthComponent
@onready var projectile_pool = $ProjectilePool
@onready var path_follow_2d = $SpawnPath/PathFollow2D
@onready var spawn_timer = $SpawnTimer

@export var enemy_scene : PackedScene
var healthbar_size = 128

func _process(_delta):
	if !is_instance_valid(player):
		if label_timer.is_stopped():
			label_timer.start()

func _on_label_timer_timeout():
	if label.visible:
		label.visible = false
	elif !label.visible:
		label.visible = true

func _on_health_component_health_change():
	color_rect.size.x *= (health_component.current_health / health_component.max_health)
	if (color_rect.size.x / healthbar_size) < 0.7:
		color_rect.color = Color.YELLOW
	if (color_rect.size.x / healthbar_size) < 0.3:
		color_rect.color = Color.RED


func _on_spawn_timer_timeout():
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	path_follow_2d.progress_ratio = randf()
	enemy.position = path_follow_2d.position
	var callable = Callable(projectile_pool, "_on_gun_component_fired")
	#enemy.gun_component.Fired.connect(callable)
	#enemy.player = player
