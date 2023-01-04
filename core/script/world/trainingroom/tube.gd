extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tubes= get_children()
	for tube in tubes:
		tube.set_speed_scale(randf_range(1.1,1.5))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
