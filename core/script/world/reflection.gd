extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bedroom_change_mirror(state) -> void:
	visible=state
	pass 


func _on_bedroom_change_mirror_mix_value(state) -> void:
	self.material.set_shader_parameter("mix_value",state)
	pass 
