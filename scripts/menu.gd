extends CanvasLayer
var mouse_position = Vector2()
var buttons = []
var max_f_size = 30
var min_f_size = 10
var any_key_pressed = false

func _ready():
	buttons += [$NewGameButton, $LoadGameButton]

func _process(_delta):
	for button in buttons:
		growing_button(button, max_f_size, min_f_size, mouse_position)

func _input(event):
	if event is InputEventMouseMotion:
		mouse_position = event.position

func growing_button(button, max_font_size, min_font_size, mouse_position):
	var button_pos = Vector2(button.position.x + (button.size.x)/2,\
	 button.position.y + (button.size.y)/2)
	var distance = mouse_position.distance_to(button_pos)
	distance = normalize_distance_from_corner(distance, button_pos)
	var new_font_size = clamp(max_font_size * distance, min_font_size, max_font_size)
	#change this line to whatever corresponds to changing the size
	button.add_theme_font_size_override("font_size", new_font_size)

func normalize_distance_from_corner(distance, pos):
	var top_left_corner = Vector2(0,0)
	var top_right_corner = Vector2(0,360)
	var bottom_right_corner = Vector2(640,360)
	var bottom_left_corner = Vector2(640,0)
	
	var _max = max(top_right_corner.distance_to(pos),top_left_corner.distance_to(pos),\
	bottom_left_corner.distance_to(pos),bottom_right_corner.distance_to(pos))
	var _min = 0
	return 1 - ((distance - _min) / (_max - _min))

func _unhandled_key_input(event):
	if event.is_pressed() && !any_key_pressed:
		$AnyKeyScreen.queue_free()
		visible = true
		$Fade.play("fade_in")
		any_key_pressed = true
