extends Node
class_name State
## This is the base class for all states in a StateMachine.
##
## It has three virtual functions that can be overridden: Enter, Exit, and Update.
## Also, it holds a reference to the state machine it belongs to.

## The state machine this state belongs to.
var state_machine: StateMachine

## This function is automatically called when the state is entered.
func Enter():
	pass

## This function is automatically called when the state is exited.
func Exit():
	pass

## This function is called every frame.
func Update(_delta):
	pass