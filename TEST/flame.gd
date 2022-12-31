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
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	raycast.set_collision_mask_value(mask,true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(raycast.get_collision_mask())
	if raycast.is_colliding()&&enable:
		EventBus.emit_signal("flame_touch_box",mask)
		enable=false
	var i = sin(time*wave_speed)
	raycast.set_scale(Vector2(1,abs(i)))
	if i<0:self.queue_free()
	time+=delta
	sprit.material.set_shader_parameter("time",abs(i))
	sprit.material.set_shader_parameter("line",line)
	pass
