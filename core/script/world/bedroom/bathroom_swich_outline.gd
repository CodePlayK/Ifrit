extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bathroom_switch_body_entered(body: Node2D) -> void:
	#self.set_light_mask(1025)
	outline_on()
	pass # Replace with function body.


func _on_bathroom_switch_body_exited(body: Node2D) -> void:
	#self.set_light_mask(1)
	outline_off()
	pass # Replace with function body.


func _on_bedroom_switch_body_entered(body: Node2D) -> void:
	#self.set_light_mask(1025)
	outline_on()
	pass # Replace with function body.


func _on_bedroom_switch_body_exited(body: Node2D) -> void:
	#self.set_light_mask(1)
	outline_off()
	pass # Replace with function body.



func _on_sleep_light_2_body_entered(body: Node2D) -> void:
	outline_on()
	pass # Replace with function body.


func _on_sleep_light_2_body_exited(body: Node2D) -> void:
	outline_off()
	pass # Replace with function body.

func outline_on():
	visible=true
	EventBus.emit_signal("change_heighlight",true)
func outline_off():
	visible=false
	EventBus.emit_signal("change_heighlight",false)
