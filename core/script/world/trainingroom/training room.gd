extends Node2D
@export var wave_center_color:Color
@export var equal_to_front:bool
@export var syn_setting:bool
@export_group("flame_wave_layer_0")
@export var wave_color_0:Color
@export var flame_rotation_0:Vector2
@export var flame_wave_speed_0:Vector2
@export var flame_line_0:Vector2
@export var flame_wave_size_0:Vector2
@export var routate_speed_0:float=1.0

@export_group("flame_wave_layer_1")
@export var wave_color_1:Color
@export var flame_rotation_1:Vector2
@export var flame_wave_speed_1:Vector2
@export var flame_line_1:Vector2
@export var flame_wave_size_1:Vector2
@export var routate_speed_1:float=1.0

@export_group("flame_wave_layer_2")
@export var wave_color_2:Color
@export var flame_rotation_2:Vector2
@export var flame_wave_speed_2:Vector2
@export var flame_line_2:Vector2
@export var flame_wave_size_2:Vector2
@export var routate_speed_2:float=1.0

@export_group("burst_settings")
@export var burst_setting:Array[Array]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_background_flames()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#routate_range:Vector2,wave_speed,line,y_scale,color,layer_name
#make_flames(Vector2(-360,360),randf_range(2.3,3.0),randf_range(2.0,5.0),randf_range(2.0,2.5),wave_color_1,wave_0)
#旋转角度,波速度,线粗细,波长度,颜色,图层,中央颜色，旋转速度(方向)
func _on_timer_timeout() -> void:
	if !syn_setting:return
	if equal_to_front:wave_center_color=wave_color_2
	change_background_flames()
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://core/scene/world/bedroom.tscn")
	pass # Replace with function body.


func _on_timer_2_timeout() -> void:
	EventBus.emit_signal("burst_flame_wave",burst_setting)
	pass # Replace with function body.

func change_background_flames():
	if equal_to_front:wave_center_color=wave_color_2
	EventBus.emit_signal("change_flames",flame_rotation_0,flame_wave_speed_0,flame_line_0,flame_wave_size_0,wave_color_0,"0",wave_center_color,routate_speed_0)
	EventBus.emit_signal("change_flames",flame_rotation_1,flame_wave_speed_1,flame_line_1,flame_wave_size_1,wave_color_1,"1",wave_center_color,routate_speed_1)
	EventBus.emit_signal("change_flames",flame_rotation_2,flame_wave_speed_2,flame_line_2,flame_wave_size_2,wave_color_2,"2",wave_center_color,routate_speed_2)
