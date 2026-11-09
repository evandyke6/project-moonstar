class_name PlayerProjectilePool

extends Node
@export var pool_size : int
@export var is_player_pool : bool
var Projectile = preload("res://scripts/components/projectile_component.tscn")
var effect : Effect
var a_pool : Array
var i_pool : Array
var counter = 0

func _ready():
	for i in range(pool_size):
		create_projectile()

func create_projectile():
	var proj : ProjectileComponent = Projectile.instantiate()
	counter += 1
	get_tree().get_root().add_child.call_deferred(proj)
	proj.LeftScreen.connect(on_left_screen)
	i_pool.append(proj)
	
	if !is_player_pool:
		proj.collision_layer = 0b10
		proj.collision_mask = 0b10
	
	#DEBUG
	#var label = Label.new()
	#label.text = str(counter)
	#proj.add_child.call_deferred(label)

func on_left_screen(proj):
	var index = a_pool.find(proj)
	if index != -1:
		a_pool.remove_at(index)
	i_pool.append(proj)

func _on_gun_component_fired(actor : GunComponent):
	var proj : ProjectileComponent
	if i_pool.size() > 0:
		proj = i_pool.pop_front()
		a_pool.append(proj)
		proj.set_properties_by_actor(actor)
		proj.activate(actor.global_position)
