extends Node
class_name Parallax
#此节点下的第一代子节点会作为视察层

@export var rsource:Node
@onready var player=rsource
@export var parallax_layer_speed_0:=7
@export var parallax_layer_speed_1:=17
@export var parallax_layer_speed_2:=17
@export var parallax_layer_speed_3:=17
@export var parallax_layer_speed_4:=17



var parallax_layers:Array=[]
var parallax_layers_speed:Array[int]=[]

var player_last_position_x:int=0
var player_last_position_x_float:float=0.0
var player_position_x:int=0
var start_position_x:Array[float]
@export var parallax_limit:=25000
var add_position_x=0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parallax_layers=get_children()
	for i in range(0,parallax_layers.size()):
		var start_position=parallax_layers[i].position.x
		start_position_x.append(start_position)
	player_last_position_x=get_player_position_x()
	parallax_layers_speed.append(parallax_layer_speed_0)
	parallax_layers_speed.append(parallax_layer_speed_1)
	parallax_layers_speed.append(parallax_layer_speed_2)
	parallax_layers_speed.append(parallax_layer_speed_3)
	parallax_layers_speed.append(parallax_layer_speed_4)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	player_position_x=get_player_position_x()
	for i in range(0,parallax_layers.size()):
		on_parallax(parallax_layers_speed[i],parallax_layers[i],start_position_x[i],delta)
	player_last_position_x=int(get_player_position_x())
	player_last_position_x_float=get_player_position_x()
func get_player_position_x()->int:
	return player.get_screen_center_position().x

func on_parallax(parallax_speed,parallax_layer,start_position_x,delta):
	if player_position_x<start_position_x+parallax_limit and player_position_x>start_position_x-parallax_limit:
		add_position_x=parallax_speed*delta*(abs(player_position_x-player_last_position_x_float))*0.1
		if player_last_position_x>int(player_position_x):
			add_position_x=add_position_x
		elif player_last_position_x<int(player_position_x):
			add_position_x=-add_position_x
		else :
			add_position_x=0
		if abs(parallax_layer.position.x+add_position_x-start_position_x)<=parallax_limit and add_position_x!=0:
			parallax_layer.position.x+=add_position_x

