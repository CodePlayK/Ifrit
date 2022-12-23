@tool
extends Path2D


enum ANIMATION_TYPE {
	LOOP,
	BOUNCE
}

@export var animation_type: ANIMATION_TYPE : set = set_animation_type
@export var speed:float = 1 : set = set_velocity

@onready var animationPlayer:=$AnimationPlayer

func set_animation_type(value):
	animation_type=value
	var ap =find_child("AnimationPlayer")
	if ap:
		paly_updated_animation(ap)
func _ready():
	paly_updated_animation(animationPlayer)

func paly_updated_animation(ap):
	match animation_type:
		ANIMATION_TYPE.LOOP:ap.play("FlyAlongPathLoop")
		ANIMATION_TYPE.BOUNCE:ap.play("FlyAlongPathBounce")
func set_velocity(value):
	var ap =find_child("AnimationPlayer")
	if ap:ap.playback_speed=value
	speed=value

