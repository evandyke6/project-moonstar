class_name ProjectileComponent
extends Area2D

var direction : Vector2
var speed : float
var velocity : Vector2
var effect : Effect
signal LeftScreen
var active : bool
var sprite : Sprite2D = Sprite2D.new()
var sprite_name
@onready var collision_shape_2d = $CollisionShape2D
@onready var projectile_sprite = $AnimatedSprite2D

#var sprite_index
#var sprite_path
#var h : float
#var w : float
#var i : int
#var region = Vector2(0,0)
#var animation_speed = 5

func _ready():
	add_child(sprite)
	deactivate()

func _physics_process(delta):
	velocity = (direction * speed * delta).limit_length(speed)
	position += velocity
#region Old Sprite System
	#sprite.region_rect = Rect2(region, Vector2(w*sprite.hframes, h*sprite.vframes))
	#if i % animation_speed == 0:
		##region += Vector2(w,0)
		#if region.x > w*(sprite.hframes-1):
			##region.x = 0
		#i = 0
	#i += 1
#endregion

#func set_properties(p_direction = Vector2.RIGHT, p_speed: float = 0, p_effect: Effect = null,\
 #p_sprite_path: String = "", p_sprite_index = 0):
	#direction = p_direction
	#rotation = direction.angle()
	#speed = p_speed
	#effect = p_effect
	##sprite_index = p_sprite_index
	##define_sprite(p_sprite_path)
	##region = Vector2(-w,h * sprite_index)

func set_properties_by_actor(actor : GunComponent):
	direction = actor.direction
	rotation = direction.angle()
	speed = actor.proj_speed
	effect = actor.effect
	sprite_name = actor.projectile_name
	#sprite_index = actor.sprite_index
	#define_sprite(actor.sprite_path)
	#region = Vector2(-w,h * sprite_index)
	
func deactivate():
	active = false
	projectile_sprite.visible = false
	collision_shape_2d.disabled = true
	set_physics_process(false)
	position = Vector2.ZERO
	
	#sprite.visible = false

func activate(pos):
	active = true
	projectile_sprite.play(sprite_name + "_fly")
	projectile_sprite.visible = true
	collision_shape_2d.disabled = false
	set_physics_process(true)
	position = pos
	
	#sprite.visible = true

#func define_sprite(p_sprite_path):
	#if p_sprite_path != sprite_path:
		#sprite_path = p_sprite_path
		#sprite.texture = load(sprite_path)
	#sprite.region_enabled = true
	#sprite.hframes = 2
	#sprite.vframes = 1
	#h = sprite.texture.get_height() / float(sprite.vframes)
	#w = sprite.texture.get_width() / float(sprite.hframes) 

func _on_visible_on_screen_notifier_2d_screen_exited():
	LeftScreen.emit(self)
	deactivate()

func _on_hurtbox_entered(area):
	if area is HurtboxComponent:
		var hurtbox : HurtboxComponent = area
		hurtbox.damage(effect.health_mod)
		LeftScreen.emit(self)
		call_deferred("deactivate")
