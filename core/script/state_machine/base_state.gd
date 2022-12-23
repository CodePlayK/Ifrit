class_name BaseState
extends Node

@onready var jump_state: BaseState
@onready var walk_state: BaseState
@onready var run_state: BaseState
@onready var dash_state: BaseState
@onready var climb_state: BaseState
@onready var fall_state: BaseState
@onready var lift_state: BaseState
@onready var idle_state: BaseState
@onready var double_jump_state: BaseState
@onready var landing_state: BaseState
@onready var ground_state: BaseState
@onready var air_state: BaseState
@onready var interactive_state: BaseState

#将要赋予的角色
var player: Player
var move:int

#初始化事件
func inite(all_states) -> void:
	for state in all_states:
		var state_name =state.get_name()
		if "fall"==state_name:fall_state=state
		if "idle"==state_name:idle_state=state
		if "jump"==state_name:jump_state=state
		if "double_jump"==state_name:double_jump_state=state
		if "ground"==state_name:ground_state=state
		if "walk"==state_name:walk_state=state
		if "run"==state_name:run_state=state
		if "dash"==state_name:dash_state=state
		if "air"==state_name:air_state=state
		if "lift"==state_name:lift_state=state
		if "climb"==state_name:climb_state=state
		if "landing"==state_name:landing_state=state
		if "interactive"==state_name:interactive_state=state
#进入该状态的方法，每次进入都会执行，在pre_physics_process之前进行
func enter() -> void:
	player.animations.play(self.get_name())
#退出该状态的方法，每次进入都会执行，在physics_process之后进行
func exit() -> void:
	pass
#有输入事件的方法,不确定与物理帧方法的顺序。慎用
func input(event: InputEvent) -> BaseState:
	return null

#游戏实际帧数的处理方法，godot默认物理帧FPS为60
#当游戏运行帧数大于物理帧FPS时：可通过传递delta获得与物理帧数同样效果
#而运行帧数小于物理帧数时，即使传递delta也可能导致问题
#运行顺序不确定
func process(delta: float) -> BaseState:
	return null
#物理帧方法，当变量涉及+=或者-+等随时间累计情况时，需要*delta
func physics_process(delta: float) -> BaseState:
	return null
#物理帧中先执行的方法
func pre_physics_process(delta: float)->BaseState:
	return null
func after_physics_process(delta: float)->BaseState:
	return null


func player_faced(move):
	if move < 0:
		player.animations.flip_h = false
	elif move > 0:
		player.animations.flip_h = true
func apply_gravity(delta):
	player.velocity.y+=player.gravity*delta
	player.velocity.y=min(player.velocity.y,player.max_gravity)
func apply_friction(delta):
	player.velocity.x=move_toward(player.velocity.x,0,player.friction*delta)
func apply_acceleration_run(v,delta):
	player.velocity.x=move_toward(player.velocity.x,player.max_speed_run*v,player.acceleration_run*delta)
func apply_acceleration_walk(v,delta):
	player.velocity.x=move_toward(player.velocity.x,player.max_speed_walk*v,player.acceleration_run*delta)
func apply_climb_acceleration_y(delta):
	player.velocity.y=move_toward(player.velocity.y,-player.max_speed_run,player.climb_speed*delta)
func apply_climb_acceleration_x(delta):
	player.velocity.x=move_toward(player.velocity.x,-player.max_speed_run,player.climb_speed*delta)
func min_jump_force(velocity,delta)->Vector2:
	var old_velocity=velocity
	if velocity.y<-player.min_jump_fource and velocity.y<0 and Input.is_action_just_released("jump"):
		velocity.y=-player.jump_speed/player.click_jump_force_limit
	return velocity
func is_on_ladder()->bool:
	if not player.ladderChecker.is_colliding():return false
	var clollider=player.ladderChecker.get_collider()
	if not clollider is Ladders:return false
	return true
func get_movement_input_x() -> int:
	var a= Input.get_axis("move_left","move_right")
	if a==0:
		return 0
	elif a>0:
		return 1
	else:
		return -1
func is_player_change_moving_direction()->bool:
	if Input.is_action_pressed("move_left") and player.velocity.x>0:
		return true
	if Input.is_action_pressed("move_right") and player.velocity.x<0:
		return true
	return false
func get_palyer_move_direction_x()->int:
		if  player.velocity.x>0:
			return 1
		elif player.velocity.x==0:
			return 0
		else :
			return -1
func get_player_faced_direction():
	if player.animations.flip_h == false:
		return -1
	else:
		return 1
func is_player_blocked()->bool:
	if player.blockCheckerRight.is_colliding() or player.blockCheckerLeft.is_colliding():
		return true
	return false
