extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bedroom_change_world_environment_exposure_white(expose, white) -> void:
	environment.set_tonemap_exposure(expose)
	environment.set_tonemap_white(white)
	pass
