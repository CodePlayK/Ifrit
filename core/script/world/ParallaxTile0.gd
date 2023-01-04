extends TileMap

@export var rsource:Node
@onready var player=rsource
@export var parallax_speed:=15
var player_last_position_x:int=0
var player_last_position_x_float:float=0.0
var player_position_x:int=0
var start_position_x:=0
var parallax_limit:=2000
var add_position_x=0
var off_set=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_position_x=position.x
	player_last_position_x=get_player_position_x()
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	player_position_x=get_player_position_x()
	if get_player_position_x()<start_position_x+parallax_limit and get_player_position_x()>start_position_x-parallax_limit:
		add_position_x=parallax_speed*delta*(abs(get_player_position_x()-player_last_position_x_float))*0.1
		if player_last_position_x>int(get_player_position_x()):
			add_position_x=add_position_x
		elif player_last_position_x<int(get_player_position_x()):
			add_position_x=-add_position_x
		else :
			add_position_x=0
		if abs(position.x+add_position_x-start_position_x)<=parallax_limit and add_position_x!=0:
			position.x+=add_position_x
	player_last_position_x=int(get_player_position_x())
	player_last_position_x_float=get_player_position_x()

func get_player_position_x()->int:
	return player.get_screen_center_position().x
