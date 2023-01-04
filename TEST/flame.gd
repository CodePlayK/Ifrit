extends Node2D
class_name Flame_Burst

@onready var sprit=$sprit
@onready var raycast=$RayCast2D
var time:float =0.0
@export var wave_speed:float =1
var line:float =2
var flag:bool =true
var enable:bool =true
var mask:int =0
var side:String ="ui_up"
var on_touching:bool=false
var left_flag:bool=true
var lock:bool=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	raycast.set_collision_mask_value(mask,true)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if raycast.is_colliding():
		if enable:
			EventBus.emit_signal("flame_touch_box",mask)
			on_touching=true
			enable=false
	else :
		on_touching=false
	if !enable&&!on_touching&&left_flag:
		EventBus.emit_signal("flame_left_box",mask)
		left_flag=false
	var i = sin(time*wave_speed)
	if !lock&&(enable||!left_flag):
		if Input.is_action_just_pressed(side):
			lock=true
			if enable:
				EventBus.emit_signal("flame_left_box_result","too_soon")
			elif !left_flag:
				EventBus.emit_signal("flame_left_box_result","too_late")
	if on_touching&&left_flag&&!lock:
		if Input.is_action_just_pressed(side):
			self.queue_free()
			EventBus.emit_signal("flame_left_box_result","success")
	raycast.set_scale(Vector2(1,abs(i)))
	if i<0:
		self.queue_free()
		EventBus.emit_signal("flame_left_box_result","miss")
	time+=delta
	sprit.material.set_shader_parameter("time",abs(i))
	sprit.material.set_shader_parameter("line",line)
	pass
