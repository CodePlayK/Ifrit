extends Node2D
@export var burst_setting:Array[Array]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	EventBus.emit_signal("burst_flame_wave",burst_setting)
	pass # Replace with function body.
