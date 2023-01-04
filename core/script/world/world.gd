extends Node
signal player_is_dead
signal change_state_ui
# Declare member variables here. Examples:
var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("player_is_dead",Callable(self,"_on_player_is_dead"))
	EventBus.connect("change_state_ui",Callable(self,"_on_change_state_ui"))
	RenderingServer.set_default_clear_color(Color.LIGHT_BLUE)
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_player_is_dead():
	emit_signal("player_is_dead")
func _on_change_state_ui():
	emit_signal("change_state_ui")
