class_name Player

extends CharacterBody2D
@export var dead_switch: bool=true
@export var gravity: int=4
@export var max_gravity: int=400
@export var acceleration_run: int=20
@export var friction: int=15
@export var max_speed_run: int=100
@export var max_speed_walk: int=100
@export var jump_speed: int=120
@export var climb_speed: int=80
@export var climb_speed_x: int=80
@export var click_jump_force_limit:=5
@export var min_jump_fource:=50
@export var fast_fall_threshold: int=10
@export var fast_fall_acceleration: int=5


var start_position

@onready var animations: = $AnimatedSprite2D
@onready var reflection: = $Reflection
@onready var states: = $state_manager
@onready var ladderChecker:=$ladderCheck
@onready var blockCheckerLeft:=$blockCheckerLeft
@onready var blockCheckerRight:=$blockCheckerRight


func _ready() -> void:
	start_position=get_position()
	states.init(self)
	reflection.hide()
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly


func _unhandled_input(event: InputEvent) -> void:
	#is_reset_player_position()
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)

func _process(delta: float) -> void:
	states.process(delta)


func _on_world_player_is_dead():
	player_is_dead()


func is_reset_player_position():
	if Input.is_mouse_button_pressed(1):
		set_position(start_position)

func player_is_dead():
	if dead_switch:
		Globle.playerDeadTimes+=1
		SoundPlayer.play_sound(SoundPlayer.player_death_sound)
		set_position(start_position)

func _on_world_change_state_ui():
	pass


func _on_bedroom_player_enter_bathroom() -> void:
	reflection.show()
	pass


func _on_bedroom_player_leave_bathroom() -> void:
	reflection.hide()
	pass
