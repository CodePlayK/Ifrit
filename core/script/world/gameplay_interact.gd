extends Area2D
var on_player:bool=false
@onready var resource=preload("res://core/dialog/test1.dialogue")
@onready var balloon=$"%Balloon"
@onready var burst_flame=$"%burst_flame"
@export_group("burst_settings")
@export var burst_setting:Array[Array]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _physics_process(delta: float) -> void:

	return
	if on_player:
		if Input.is_action_just_pressed("ui_up"):
			burst_by_uidirection(1)
		if Input.is_action_just_pressed("ui_right"):
			burst_by_uidirection(2)
		if Input.is_action_just_pressed("ui_down"):
			burst_by_uidirection(3)
		if Input.is_action_just_pressed("ui_left"):
			burst_by_uidirection(4)
	pass

func _on_body_entered(body: Node2D) -> void:
	EventBus.emit_signal("clear_result")
	burst_flame.start(2.0)
	on_player=true
	balloon.start(resource,"on_gameplay")
	pass


func _on_body_exited(body: Node2D) -> void:
	burst_flame.stop()
	on_player=false
	balloon.hide()
func burst_by_uidirection(direction):
		var side:Array
		side.append(direction)
		side.append(1)
		burst_setting.append(side)
		EventBus.emit_signal("burst_flame_wave",burst_setting)
		burst_setting.clear()


func _on_burst_flame_timeout() -> void:
	EventBus.emit_signal("burst_flame_wave",randi_range(1,4),randi_range(0,2))
	pass
