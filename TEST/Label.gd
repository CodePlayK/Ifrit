extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_text(str(Time.get_time_string_from_system()))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass


func _on_timer_timeout() -> void:
	set_text(str(Time.get_time_string_from_system()))
	pass
