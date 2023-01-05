extends Node2D
var poly_flame
var burst_flame
var ray_list:Array
var flame_list:Array

var success:int
var too_soon:int
var too_late:int
var miss:int

@export var wave_color_defalut:Color
@export var flame_center_scale:float=1.0
@onready var wave=$wave
@onready var wave_0=$"wave/0"
@onready var wave_1=$"wave/1"
@onready var wave_2=$"wave/2"
@onready var talk=$"wave/aniplayer_talk"
@onready var aniplayer_burst_flame=$"burst_wave/aniplayer_burst_flame"
@onready var burst=$"burst_wave/burst"
@onready var label=$"Label"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("change_flames",Callable(self,"_on_change_flames"))
	EventBus.connect("burst_flame_wave",Callable(self,"_on_burst_flame_wave"))
	EventBus.connect("flame_touch_box",Callable(self,"_on_flame_touch_box"))
	EventBus.connect("flame_left_box",Callable(self,"_on_flame_left_box"))
	EventBus.connect("flame_left_box_result",Callable(self,"_on_flame_left_box_result"))
	EventBus.connect("clear_result",Callable(self,"_on_clear_result"))
	poly_flame=preload("res://core/scene/world/flame.tscn")
	burst_flame=preload("res://core/scene/world/flame_burst.tscn" )
	for i in range(0,20):
		#旋转角度,波速度,线粗细,波长度,颜色,图层
		make_flames(Vector2(-360,360),randf_range(2.3,3.0),randf_range(10,15),randf_range(1.7,2),wave_color_defalut,wave_0)
	for i in range(0,20):
		#旋转角度,波速度,A线粗细,波长度,颜色,图层
		make_flames(Vector2(-360,360),randf_range(1,2),randf_range(7,10),randf_range(1.4,1.7),wave_color_defalut,wave_1)
	for i in range(0,20):
		#旋转角度,波速度,A线粗细,波长度,颜色,图层
		make_flames(Vector2(-360,360),randf_range(1,2),randf_range(7,10),randf_range(1,1.4),wave_color_defalut,wave_2)
	pass


func make_flames(routate_range:Vector2,wave_speed,line,y_scale,color,layer):
	var flame = poly_flame.instantiate()
	var flame_rotate=randf_range(routate_range.x, routate_range.y)
	flame.set_rotation_degrees(flame_rotate)
	flame.get_node("sprit").material.set_shader_parameter("wave_speed",wave_speed)
	flame.get_node("sprit").material.set_shader_parameter("line",line)
	flame.get_node("sprit").material.set_shader_parameter("color",Vector4(color.r,color.g,color.b,color.a))
	flame.set_scale(Vector2(1.0,y_scale))
	layer.add_child(flame)

func make_burst_flames(routate_range:Vector2,wave_speed,line,y_scale,color,layer,cube_side):
	var flame = burst_flame.instantiate()
	var burst_rotation:int=burst.get_rotation_degrees()
	var rotate=randf_range(routate_range.x, routate_range.y)
	rotate=rotate-burst_rotation-10
	flame.set_rotation_degrees(rotate)
	flame.wave_speed=wave_speed
	flame.line=line
	flame.wave_speed=wave_speed
	#设置碰撞层
	flame.mask=cube_side
	match cube_side-12:
		1:flame.side="ui_up"
		2:flame.side="ui_right"
		3:flame.side="ui_down"
		4:flame.side="ui_left"
	flame.get_node("sprit").material.set_shader_parameter("color",Vector4(color.r,color.g,color.b,color.a))
	#flame.get_node("RayCast2D").set_collision_mask_value(cube_side,true)
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


func _on_change_flames(routate_range:Vector2,wave_speed:Vector2,line:Vector2,y_scale,color,layer_name,wave_center_color,routate_speed):
	var layer=wave.find_child(layer_name)
	var color_v4=Vector4(color.r,color.g,color.b,color.a)
	var center_color_v4=Vector4(wave_center_color.r,wave_center_color.g,wave_center_color.b,wave_center_color.a)
	change_flame(routate_range,wave_speed,line,y_scale,color_v4,layer,center_color_v4,routate_speed)

func _on_burst_flame_wave(side,copy_layer):
	var burst_vec=Vector2.ZERO
	var layer
	var color
	var color1
	#四边有效象限
	match side:
		1:
			burst_vec=Vector2(-35,35)
		2:
			burst_vec=Vector2(55,125)
		3:
			burst_vec=Vector2(145,215)
		4:
			burst_vec=Vector2(-55,-125)
	#获取对应背景层颜色
	layer=wave.find_child(str(copy_layer))
	var flames=	layer.get_children()
	for flame in flames:
		if flame is Flame:
			color=flame.get_node("sprit").material.get_shader_parameter("color")
			break
	#Color转为shader的vec4向量
	color1.r=color.x
	color1.g=color.y
	color1.b=color.z
	color1.a=color.w
	#旋转角度,波速度,线粗细,波长度,颜色,图层，碰撞mark
	make_burst_flames(burst_vec,randf_range(1,5),randf_range(2,2),randf_range(2.5,3.5),color1,burst,side+12)
	aniplayer_burst_flame.play("rotate")
	pass

func _on_flame_touch_box(mask) -> void:
	print("接触"+str(mask))
	pass

func _on_flame_left_box(mask) -> void:
	print("离开"+str(mask))
	pass
func _on_flame_left_box_result(result) -> void:
	match result:
		"too_soon":too_soon+=1
		"too_late":too_late+=1
		"miss":miss+=1
		"success":success+=1
	label.text="收容:"+str(success)+"\n过快:"+str(too_soon)+"\n过慢:"+str(too_late)+"\nMISS:"+str(miss)
	pass
func _on_clear_result() -> void:
	too_soon=0
	too_late=0
	miss=0
	success=0
	label.text="收容:"+str(success)+"\n过快:"+str(too_soon)+"\n过慢:"+str(too_late)+"\nMISS:"+str(miss)
	pass
