extends Area2D
var on_plyer:bool = false
@onready var balloon=%Balloon
@onready var resource=preload("res://core/dialog/test1.dialogue")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_plyer:
		if Input.is_action_just_pressed("interactive"):
			exit_room_to_corridor()
	pass


func _on_body_entered(body: Node2D) -> void:
	on_plyer=true
	balloon.start(resource,"on_to_corridor")
	pass

func exit_room_to_corridor():
	EventBus.emit_signal("transition_show","RIGHT_LEFT")
	await EventBus.transition_complete
	EventBus.emit_signal("change_room","corridor")
	pass


func _on_body_exited(body: Node2D) -> void:
	balloon.hide()
	on_plyer=false
	pass
