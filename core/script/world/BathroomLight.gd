extends PointLight2D
@onready var resource=preload("res://core/dialog/test1.dialogue")
@onready var balloon=$"%Balloon"
var on_player:bool=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_player and Input.is_action_just_pressed("interactive"):
		visible=!visible
	pass


func _on_bedroom_change_bathroom_light_energy(state) -> void:
	if state:
		energy=1.4
	else :
		energy=1.2
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	on_player=true
	balloon.start(resource,"on_bathroom_light")
	pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	balloon.hide()
	on_player=false
	pass


func _on_visibility_changed() -> void:
	EventBus.emit_signal("change_mirror",visible)
	pass


func _on_bedroom_change_bathroom_light(state) -> void:
	visible=state
	pass # Replace with function body.
