extends CanvasLayer
@onready var aniplayer =$"aniplayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("transition_show",Callable(self,"_on_transition_show"))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_transition_show(state):
	self.show()
	match state:
		"RIGHT_ENTER":
			aniplayer.play("right to left")
		"RIGHT_LEFT":
			aniplayer.play_backwards("right to left")
		"LEFT_ENTER":
			aniplayer.play("left to right")
		"LEFT_LEFT":
			aniplayer.play_backwards("left to right")
		"MID_ENTER":
			aniplayer.play("mid to side")
		"MID_LEFT":
			aniplayer.play_backwards("mid to side")

func _on_aniplayer_animation_finished(anim_name: StringName) -> void:
	EventBus.emit_signal("transition_complete")
	pass
