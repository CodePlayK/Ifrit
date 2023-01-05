extends Node

var palyerDead=false
var playerDeadTimes=0
var double_jump_flag:bool=true# Declare member variables here. Examples:
var state_ui_text:String = ""
var palyer_move :int
var last_state:BaseState
var current_state:BaseState
var current_room:String
var last_room:String
var bedroom_light_state:bool
var player_movement_lcok:bool=false

var current_cutscene:String
var playing_cutscene:bool=false

func _ready():
	EventBus.connect("change_room",Callable(self,"_on_change_room"))
	pass

func _on_change_room(room):
	last_room=current_room
	print("上个场景:"+last_room)
	match room:
		"bedroom":
			to_bedroom()
		"trainingroom":
			to_trainingroom()
		"corridor":
			to_corridor()

func to_corridor():
	get_tree().change_scene_to_file("res://core/scene/world/corridors/corridor.tscn")
func to_bedroom():
	get_tree().change_scene_to_file("res://core/scene/world/bedroom.tscn" )
func to_trainingroom():
	get_tree().change_scene_to_file("res://core/scene/world/training room.tscn" )
