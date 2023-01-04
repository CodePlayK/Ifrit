extends CharacterBody2D

var direction=Vector2.RIGHT
var player_velocity=Vector2.ZERO
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@onready var edgeCheckRight=$edgeCheckRight
@onready var edgeCheckLeft=$edgeCheckLeft
@onready var sprite=$AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	#判断是否碰到墙壁（竖向的碰撞区域）
	var found_wall=is_on_wall()
	#用射线判断是否来到边缘
	var found_egde=not edgeCheckLeft.is_colliding() or not edgeCheckRight.is_colliding()
	if found_wall or found_egde:
		#行动方向翻转
		direction*=-1
		#翻转精灵
		sprite.flip_h=!sprite.flip_h
	player_velocity=direction*25
	set_velocity(player_velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
