extends Node

@export var starting_node:Node
@export  var state_machine_sript_path: String

@onready var starting_state: BaseState = starting_node
signal change_state_ui

var current_state: BaseState
var all_states: Array

func change_state(new_state: BaseState) -> void:
	if current_state and current_state!=new_state:
		current_state.exit()
		Globle.last_state=current_state
		Globle.state_ui_text=print_a_to_b(current_state.get_name(),new_state.get_name())
		emit_signal("change_state_ui")
		current_state = new_state
		Globle.current_state=current_state
		current_state.enter()

func init(player: Player) -> void:
	print("载入所有state")
	get_childen_node(self)
	for state in all_states:
		state.player = player
		state.inite(all_states)
	current_state=starting_state
	change_state(starting_state)

func physics_process(delta: float) -> void:
	var new_state = current_state.pre_physics_process(delta)
	if !new_state:
		new_state = current_state.physics_process(delta)
		var new_state2 = current_state.after_physics_process(delta)
		if new_state2:
			change_state(new_state2)
		else:
			if new_state:
				change_state(new_state)
	else :
		change_state(new_state)
func input(event: InputEvent) -> void:
	var new_state
	if current_state:
		new_state = current_state.input(event)
	if new_state:
		change_state(new_state)

func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state:
		change_state(new_state)

func get_childen_node(node:Node):
	for child in node.get_children():
		all_states.append(child)
		if child:
			get_childen_node(child)
func print_a_to_b(a,b):
	var format_string = "%s TO %s"
	var actual_string = format_string % [a, b]
	print(actual_string)
	return actual_string


func _on_change_state_ui():
	EventBus.emit_signal("change_state_ui")
	pass
