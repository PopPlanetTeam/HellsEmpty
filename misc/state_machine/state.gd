extends Node
class_name State
## This is the base class for all states in a StateMachine.
##
## It has three virtual functions that can be overridden: Enter, Exit, and Update.

## This signal is emitted when a transition to another state is requested.
signal transition(state_from: State, state_to_transition: String)

## This function is called when the state is entered.
func Enter():
	pass

## This function is called when the state is exited.
func Exit():
	pass

## This function is called every frame.
func Update(_delta):
	pass

func PhysicsProcess(_delta):
	pass