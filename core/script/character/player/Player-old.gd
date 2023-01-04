extends CharacterBody2D
#赋予该对象全局名称

enum {
	MOVE,CLIMB
}
var playerState=MOVE
var velocity=Vector2.ZERO

var skinFlag=true
var double_jump_flag=false
var buffer_jump_flag=false
var edge_jump_flag=false

#使用这种挂载方式，编辑器才能自动填充资源变量名
var moveCofig_fast:=preload("res://core/resource/character/player/PlayerMovementConfig/FAST.tres") as PlayerMoveConfig_FAST
var moveCofig_default=preload("res://core/resource/character/player/PlayerMovementConfig/DEFAULT.tres") as PlayerMoveConfig_DEFAULT
@export var moveCofig: Resource

var start_position
#onready确保资源以成功载入
@onready var animatedSprite:=$AnimatedSprite2D
@onready var label:=$Camera2D/Label
@onready var label2:=$Camera2D/Label2
@onready var ladderChenck:=$ladderCheck
@onready var jumpBufferTimer:=$JumpBufferTimer
@onready var edgeJumpTimer:=$EdgeJumpTimer



func _ready():
	#记录初始化位置
	start_position= get_position()
	#运动设为默认配置
	moveCofig=moveCofig_fast
	#载入皮肤
	animatedSprite.frames=load("res://core/resource/character/player/Player_Skin_Green.tres")

#delta（物理帧）=1秒/FPS
func _physics_process(delta):
	#初始化角色位置
	is_reset_player_position()
	var input=Vector2.ZERO
	#get_action_strength即适合键盘也兼容手柄,会返回一个介于0-1之间的数字
	#input.x=Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input.x=Input.get_axis("ui_left","ui_right")
	input.y=Input.get_axis("ui_up","ui_down")
	match playerState:
		MOVE:move_state(input)
		CLIMB:climb_state(input)

func move_state(input):#刚刚离开边缘（边缘跳），刚刚离开地面，在地面（跳），在空中上升（二段跳），在空中下降（二段跳，跳跃缓冲）
	is_change_state_to_CLIMB()
	apply_gravity()
	if input.x==0:
		none_input_event()
	else:
		apply_acceleration(input.x)
		change_animation("run",-1)
		palyer_faced_direction(input)
	#判断是否在地面
	if is_on_floor() or edge_jump_flag:
		#接触地面装载二段跳
		double_jump_flag=true
		if Input.is_action_just_pressed("ui_up") or buffer_jump_flag:
			jump()
			buffer_jump_flag=false
			edge_jump_flag=false
	else:
		#限制单击跳跃时不会跳的过高
		is_min_jump_speed()
		#快速下落：在跳跃顶点开始下落到速度为10后，开始加速下落
		is_fast_fall()
		change_animation("jump",-1)
		#二段跳
		if Input.is_action_just_pressed("ui_up") and double_jump_flag:
			jump()
			change_animation("idle",-1)
			double_jump_flag=false
		#跳跃宽容度
		if Input.is_action_just_pressed("ui_up"):
			buffer_jump_flag=true
			jumpBufferTimer.start()

	#记录上一帧是否在地面上
	var was_on_floor=is_on_floor()
	#移动并侦测碰撞，返回值为碰撞检测后的向量
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	velocity= velocity
	#如果上一帧不在地面上，且当前帧在地面则判断为刚落地
	var just_landed=not was_on_floor and is_on_floor()
	var just_left_edge=was_on_floor and velocity.y>=0
	if just_left_edge:
		edgeJumpTimer.start()
		edge_jump_flag=true
	#立即切换到落地帧
	if just_landed:
		change_animation("run",1)
	pass

func climb_state(input):
	is_change_to_MOVE()
	if input.length()!=0:
		change_animation("run",-1)
	else:
		change_animation("idle",-1)
	velocity=input*moveCofig.climb_speed
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	velocity=velocity
	pass

func apply_gravity():
	velocity.y+=moveCofig.gravity
	velocity.y=min(velocity.y,moveCofig.max_gravity)
func apply_friction():
	velocity.x=move_toward(velocity.x,0,moveCofig.friction)
func apply_acceleration(v):
	velocity.x=move_toward(velocity.x,moveCofig.max_speed_run*v,moveCofig.acceleration)

func _on_JumpBufferTimer_timeout():
	buffer_jump_flag=false
	pass 
func _on_EdgeJumpTimer_timeout():
	edge_jump_flag=false
	pass 
func is_change_state_to_CLIMB():
	if is_on_ladder() and Input.is_action_pressed("ui_up"):
		playerState=CLIMB
func none_input_event():
	apply_friction()
	change_animation("idle",-1)
func palyer_faced_direction(input):
	if input.x>0:
		animatedSprite.flip_h=true
	else:
		animatedSprite.flip_h=false
func is_min_jump_speed():
	if velocity.y<moveCofig.jump_speed/2 and Input.is_action_just_released("ui_up"):
			velocity.y=moveCofig.jump_speed/2
func is_fast_fall():
	if velocity.y>moveCofig.fast_fall_threshold:
			velocity.y+=moveCofig.fast_fall_acceleration
func jump():velocity.y=moveCofig.jump_speed
func is_reset_player_position():
	if Input.is_mouse_button_pressed(1):
		set_position(start_position)
func change_animation(string,index):player
	animatedSprite.animation=string
	if index!=-1:animatedSprite.frame=index
func is_change_to_MOVE():
	if !is_on_ladder():
		playerState=MOVE
#通过raycast判断是否与环境伤害set正在碰撞
func is_on_ladder():
	if not ladderChenck.is_colliding():return false
	var clollider=ladderChenck.get_collider()
	if not clollider is Ladders:return false
	return true

func player_dead():
	Globle.playerDeadTimes+=1
	label2.text="挂 "+ str(Globle.playerDeadTimes)
	set_position(start_position)
	if skinFlag:
		moveCofig=moveCofig_fast
		label.text="BUFF ON"
	else:
		moveCofig=moveCofig_default
		label.text="BUFF OFF"
	skinFlag=!skinFlag

func _on_world_player_is_dead():
	player_dead()
	pass 
