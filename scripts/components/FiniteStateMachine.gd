class_name FSM

extends Node
@export var initial_state:State

var current_state : State
@export var state_list: Array[State] = []
var state_dict : Dictionary

func _ready():
	for s in state_list:
		state_dict[s.name.to_lower()] = s
		s.Transitioned.connect(on_change_state)
	if initial_state:
		initial_state.enter_state()
		current_state = initial_state
		

func _physics_process(delta):
	current_state.physics_update(delta)

func _process(delta):
	current_state.update(delta)
	print(current_state)

func on_change_state(state, new_state_name):
	if state != current_state:
		return
	var new_state = get_state(new_state_name.to_lower())
	
	if new_state is State:
		state.exit_state()
		new_state.enter_state()
		current_state = new_state
	

func get_state(target_state : String) -> State:
	return state_dict.get(target_state)
