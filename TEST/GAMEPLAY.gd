extends Node2D
var poly_flame
var burst_flame
var ray_list:Array
var flame_list:Array
@export var wave_color_1:Color
@export var wave_color_2:Color
@export var flame_center_scale:float=1.0
@onready var wave=$wave
@onready var wave_0=$"wave/0"
@onready var wave_1=$"wave/1"
@onready var wave_2=$"wave/2"
@onready var talk=$"wave/talk"
@onready var burst=$"burst_wave/burst"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("change_flames",Callable(self,"_on_change_flames"))
	EventBus.connect("burst_flame_wave",Callable(self,"_on_burst_flame_wave"))
	poly_flame=preload("res://core/scene/world/flame.tscn")
	burst_flame=preload("res://core/scene/world/flame_burst.tscn" )
	for i in range(0,20):
		#旋转角度,波速度,线粗细,波长度,颜色,图层
		make_flames(Vector2(-360,360),randf_range(2.3,3.0),randf_range(10,15),randf_range(1.7,2),wave_color_1,wave_0)
	for i in range(0,20):
		#旋转角度,波速度,A线粗细,波长度,颜色,图层
		make_flames(Vector2(-360,360),randf_range(1,2),randf_range(7,10),randf_range(1.4,1.7),wave_color_2,wave_1)
	for i in range(0,20):
		#旋转角度,波速度,A线粗细,波长度,颜色,图层
		make_flames(Vector2(-360,360),randf_range(1,2),randf_range(7,10),randf_range(1,1.4),wave_color_2,wave_2)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func make_flames(routate_range:Vector2,wave_speed,line,y_scale,color,layer):
	var flame = poly_flame.instantiate()
	var rotate=randf_range(routate_range.x, routate_range.y)
	flame.set_rotation_degrees(rotate)
	flame.get_node("sprit").material.set_shader_parameter("wave_speed",wave_speed)
	flame.get_node("sprit").material.set_shader_parameter("line",line)
	flame.get_node("sprit").material.set_shader_parameter("color",Vector4(color.r,color.g,color.b,color.a))
	flame.set_scale(Vector2(1.0,y_scale))
	layer.add_child(flame)

func make_burst_flames(routate_range:Vector2,wave_speed,line,y_scale,color,layer):
	var flame = burst_flame.instantiate()
	var rotate=randf_range(routate_range.x, routate_range.y)
	flame.set_rotation_degrees(rotate)
	flame.wave_speed=wave_speed
	flame.line=line
	flame.wave_speed=wave_speed
	flame.get_node("sprit").material.set_shader_parameter("color",Vector4(color.r,color.g,color.b,color.a))
	flame.set_scale(Vector2(1.0,y_scale))
	layer.add_child(flame)


func change_flame(routate_range:Vector2,wave_speed:Vector2,line:Vector2,y_scale:Vector2,color_v4,layer,center_color_v4,routate_speed):
	var flames=	layer.get_children()
	if flames.size()==0:pass
	for flame in flames:
		if !flame is Flame:
			if flame.get_class()=="AnimationPlayer":
				flame.set_speed_scale(routate_speed)
				continue
			flame.material.set_shader_parameter("color",center_color_v4)
			flame.set_scale(Vector2(0.059*flame_center_scale,0.059*flame_center_scale))
			continue
		if routate_range!=Vector2.ZERO:
			flame.rotate(randf_range(routate_range.x, routate_range.y))
		if wave_speed!=Vector2.ZERO:
			flame.get_node("sprit").material.set_shader_parameter("wave_speed",randf_range(wave_speed.x,wave_speed.y))
		if line!=Vector2.ZERO:
			flame.get_node("sprit").material.set_shader_parameter("line",randf_range(line.x,line.y))
		if color_v4!=-Vector4.ONE:
			flame.get_node("sprit").material.set_shader_parameter("color",color_v4)
		if y_scale!=Vector2.ZERO:
			flame.set_scale(Vector2(1.0,randf_range(y_scale.x,y_scale.y)))

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("hit!")
	pass # Replace with function body.

func _on_change_flames(routate_range:Vector2,wave_speed:Vector2,line:Vector2,y_scale,color,layer_name,wave_center_color,routate_speed):
	var layer=wave.find_child(layer_name)
	var color_v4=Vector4(color.r,color.g,color.b,color.a)
	var center_color_v4=Vector4(wave_center_color.r,wave_center_color.g,wave_center_color.b,wave_center_color.a)
	change_flame(routate_range,wave_speed,line,y_scale,color_v4,layer,center_color_v4,routate_speed)

#触碰方向(1-4),图层
func _on_burst_flame_wave(burst_setting):
	var burst_vec=Vector2.ZERO
	var layer
	var color
	var color1:Color
	for burst_set in burst_setting:
		#-45,45,135,-135,-45
		match burst_set[0]:
			1:burst_vec=Vector2(-40,40)
			2:burst_vec=Vector2(50,130)
			3:burst_vec=Vector2(-140,140)
			4:burst_vec=Vector2(-50,-130)
		layer=wave.find_child(str(burst_set[1]))
		var flames=	layer.get_children()
		for flame in flames:
			if flame is Flame:
				color=flame.get_node("sprit").material.get_shader_parameter("color")
				break
		color1.r=color.x
		color1.g=color.y
		color1.b=color.z
		color1.a=color.w
		#旋转角度,波速度,线粗细,波长度,颜色,图层
		#await talk.animation_finished
		make_burst_flames(burst_vec,randf_range(2.3,3.0),randf_range(2,2),randf_range(2,2.5),color1,burst)
	pass


func _on_talk_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
