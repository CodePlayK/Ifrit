extends PointLight2D
@onready var resource=preload("res://core/dialog/test1.dialogue")
@onready var balloon=$"%Balloon"
var on_player:bool=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_player and Input.is_action_just_pressed("interactive"):
		if !visible:
			EventBus.emit_signal("change_sleep_light",false)
		visible=!visible


func _on_area_2d_body_entered(body: Node2D) -> void:
	on_player=true
	balloon.start(resource,"on_main_light")
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	balloon.hide()
	on_player=false
	pass # Replace with function body.


func _on_bedroom_change_main_light(state) -> void:
	visible=state
	pass # Replace with function body.


func _on_visibility_changed() -> void:
	if !visible:
		EventBus.emit_signal("change_worldEnvironment_exposure_white",2.7,2.7)
	else:
		EventBus.emit_signal("change_worldEnvironment_exposure_white",0.6,0.6)
	EventBus.emit_signal("change_logo_light",!visible)
	EventBus.emit_signal("change_desk_light",!visible)
	EventBus.emit_signal("change_background_light",visible)
	EventBus.emit_signal("change_bathroom_light_enegy",visible)

	pass # Replace with function body.
