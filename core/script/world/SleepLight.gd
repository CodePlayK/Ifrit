extends Area2D
@onready var resource=preload("res://core/dialog/test1.dialogue")
@onready var balloon=$"%Balloon"
@onready var sleepLight=$"SleepLight"
var on_player:bool=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if on_player and Input.is_action_just_pressed("interactive"):
		if sleepLight.visible:
			EventBus.emit_signal("change_main_light",true)
		else :
			EventBus.emit_signal("change_main_light",false)
		sleepLight.visible=!sleepLight.visible




func _on_body_entered(body: Node2D) -> void:
	balloon.start(resource,"on_sleep_light")
	on_player=true
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	on_player=false
	balloon.hide()
	pass # Replace with function body.


func _on_bedroom_change_sleep_light(state) -> void:
	sleepLight.visible=state
	pass # Replace with function body.
