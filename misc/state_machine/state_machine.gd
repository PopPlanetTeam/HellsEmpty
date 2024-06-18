extends Node
class_name StateMachine
## This script is a simple state machine that can be used to manage states in a game.

## The current state of the state machine.
var current_state: State
## This is a dictionary that contains all the states of the state machine.
var state_dictionary: Dictionary

## The initial state of the state machine.
@export var initial_state: State

## In this function, we get all the children of the StateMachine node, add them to the state_dictionary and removes from the tree. The only state remaining is the initial_state.
##
## If the initial_state variable is set, we set the current_state to the initial_state and call the Enter function of the initial_state.
func _ready():
	if not initial_state:
		printerr("StateMachine> Initial state not set. Exiting.")
		get_tree().quit()
	
	for child in get_children():
		if child is State:
			state_dictionary[child.name.to_lower()] = child
			child.state_machine = self

			# Remove all states from the tree except the initial state
			if child != initial_state:
				remove_child(child)

	current_state = initial_state
	current_state.Enter()

## This function is called when a node wants to change the state of the state machine.
##
## We change the current_state to the state_to_transition state and call the Exit function of the current_state and the Enter function of the new state.
func change_to_state(state_from: State, state_to_transition: String):
	if state_from != current_state:
		return
	
	# Set to_lower in new state name to avoid case sensitivity
	state_to_transition = state_to_transition.to_lower()

	if state_dictionary.has(state_to_transition):
		current_state.Exit()
		remove_child(current_state)
		var new_state = state_dictionary[state_to_transition]
		add_child(new_state)
		new_state.Enter()
		current_state = new_state
	else:
		printerr("StateMachine> State not found: " + state_to_transition)

## In this function, we call the Update function of the current state.
func _process(delta):
	current_state.Update(delta)
