extends Node
signal change_main_light(state)
signal change_sleep_light(state)
signal change_logo_light(state)
signal change_desk_light(state)
signal change_background_light(state)
signal change_bathroom_light_enegy(state)
signal change_worldEnvironment_exposure_white(expose,white)
@export var day_light:bool=true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("change_main_light",Callable(self,"_on_change_main_light"))
	EventBus.connect("change_sleep_light",Callable(self,"_on_change_sleep_light"))
	EventBus.connect("change_logo_light",Callable(self,"_on_change_logo_light"))
	EventBus.connect("change_desk_light",Callable(self,"_on_change_desk_light"))
	EventBus.connect("change_background_light",Callable(self,"_on_change_background_light"))
	EventBus.connect("change_bathroom_light_enegy",Callable(self,"_on_change_bathroom_light_enegy"))
	EventBus.connect("change_worldEnvironment_exposure_white",Callable(self,"_on_change_worldEnvironment_exposure_white"))
	if day_light:
		on_daylight()
	else :
		on_nightlight()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
func _on_change_bathroom_light_enegy(state):
	emit_signal("change_bathroom_light_enegy",state)
func _on_change_worldEnvironment_exposure_white(expose,white):
	emit_signal("change_worldEnvironment_exposure_white",expose,white)

func on_daylight():
	emit_signal("change_main_light",true)
	emit_signal("change_sleep_light",false)
	emit_signal("change_logo_light",false)
	emit_signal("change_desk_light",false)
func on_nightlight():
	emit_signal("change_desk_light",true)
	emit_signal("change_main_light",false)
	emit_signal("change_sleep_light",true)
	emit_signal("change_logo_light",true)
