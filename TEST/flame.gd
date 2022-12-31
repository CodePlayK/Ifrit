extends Node2D
class_name Flame_Burst

@onready var sprit=$sprit
var time:float =0.0
@export var wave_speed:float =1
var line:float =2
var flag:bool =true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var i = sin(time*wave_speed)
	if i<0:self.queue_free()
	time+=delta
	sprit.material.set_shader_parameter("time",abs(i))
	sprit.material.set_shader_parameter("line",line)
	pass
