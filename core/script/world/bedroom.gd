extends Node
signal change_main_light(state)
signal change_sleep_light(state)
signal change_logo_light(state)
signal change_desk_light(state)
signal change_background_light(state)
signal change_bathroom_light_energy(state)
signal change_worldEnvironment_exposure_white(expose,white)
signal player_enter_bathroom()
signal player_leave_bathroom()
signal change_bathroom_light(state)
signal change_mirror(state)
signal change_mirror_mix_value(state)
signal change_heighlight(state)
signal cutscene_finished()
@export var day_light:bool=true
@onready var mainLight=%MainLight
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.emit_signal("transition_show","RIGHT_ENTER")
	Globle.current_room="bedroom"
	EventBus.connect("change_main_light",Callable(self,"_on_change_main_light"))
	EventBus.connect("change_sleep_light",Callable(self,"_on_change_sleep_light"))
	EventBus.connect("change_logo_light",Callable(self,"_on_change_logo_light"))
	EventBus.connect("change_desk_light",Callable(self,"_on_change_desk_light"))
	EventBus.connect("change_background_light",Callable(self,"_on_change_background_light"))
	EventBus.connect("change_bathroom_light_energy",Callable(self,"_on_change_bathroom_light_energy"))
	EventBus.connect("change_worldEnvironment_exposure_white",Callable(self,"_on_change_worldEnvironment_exposure_white"))
	EventBus.connect("player_enter_bathroom",Callable(self,"_on_player_enter_bathroom"))
	EventBus.connect("player_leave_bathroom",Callable(self,"_on_player_leave_bathroom"))
	EventBus.connect("change_bathroom_light",Callable(self,"_on_change_bathroom_light"))
	EventBus.connect("change_mirror",Callable(self,"_on_change_mirror"))
	EventBus.connect("change_mirror_mix_value",Callable(self,"_on_change_mirror_mix_value"))
	EventBus.connect("change_heighlight",Callable(self,"_on_change_heighlight"))
	EventBus.connect("cutscene_finished",Callable(self,"_on_cutscene_finished"))

	if day_light||Globle.bedroom_light_state:
		on_daylight()
	else :
		on_nightlight()


func _on_change_main_light(state):
	emit_signal("change_main_light",state)
func _on_change_sleep_light(state):
	emit_signal("change_sleep_light",state)
func _on_change_logo_light(state):
	emit_signal("change_logo_light",state)
func _on_change_desk_light(state):
	emit_signal("change_desk_light",state)
func _on_change_background_light(state):
	emit_signal("change_background_light",state)
func _on_change_bathroom_light_energy(state):
	emit_signal("change_bathroom_light_energy",state)
func _on_change_worldEnvironment_exposure_white(expose,white):
	emit_signal("change_worldEnvironment_exposure_white",expose,white)

func on_daylight():
	EventBus.emit_signal("change_worldEnvironment_exposure_white",0.6,0.6)
	emit_signal("change_main_light",true)
func on_nightlight():
	EventBus.emit_signal("change_worldEnvironment_exposure_white",2.7,2.7)
	emit_signal("change_desk_light",true)
	emit_signal("change_main_light",false)
	emit_signal("change_sleep_light",true)
	emit_signal("change_logo_light",true)
func _on_player_enter_bathroom():
	emit_signal("player_enter_bathroom")
func _on_player_leave_bathroom():
	emit_signal("player_leave_bathroom")
func _on_change_bathroom_light(state):
	emit_signal("change_bathroom_light",state)
func _on_change_mirror(state):
	emit_signal("change_mirror",state)
func _on_change_mirror_mix_value(state):
	emit_signal("change_mirror_mix_value",state)
func _on_change_heighlight(state):
	emit_signal("change_heighlight",state)
func _on_cutscene_finished(state):
	emit_signal("cutscene_finished",state)


func _on_sprite_2d_body_entered(body: Node2D) -> void:
	Globle.bedroom_light_state=mainLight.visible
	EventBus.emit_signal("transition_show","RIGHT_LEFT")
	await EventBus.transition_complete
	EventBus.emit_signal("change_room","trainingroom")

	pass
