extends PointLight2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bedroom_change_logo_light(state) -> void:
	visible=state
	pass # Replace with function body.
