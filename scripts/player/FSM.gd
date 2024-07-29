extends Node
class_name FSM


var current_state : State
var states : Dictionary = {}
@export var initial_state : State


func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.fsm = self
	
	change_state(initial_state.name)


func change_state(new_state_name: String):
	var new_state = states[new_state_name]
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state = new_state

