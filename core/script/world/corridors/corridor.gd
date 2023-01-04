extends Node2D
var on_plyer:bool = false
@onready var balloon=$"Balloon"
@onready var resource=preload("res://core/dialog/test1.dialogue")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globle.current_room="corridor"
	EventBus.emit_signal("transition_show","MID_ENTER")
	await EventBus.transition_complete
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_plyer:
		if Input.is_action_just_pressed("interactive"):
			EventBus.emit_signal("transition_show","MID_LEFT")
			await EventBus.transition_complete
			EventBus.emit_signal("change_room","trainingroom")

func _on_to_trainningroom_body_entered(body: Node2D) -> void:
	balloon.start(resource,"on_to_trainingroom")
	on_plyer=true
	pass


func _on_to_trainningroom_body_exited(body: Node2D) -> void:
	balloon.hide()
	on_plyer=false
	pass
