extends Node
@onready var balloon=$"%Balloon"
@onready var aniplayer=$aniplayer
@onready var resource=preload("res://core/dialog/cutscene/0_0_bedroom.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("bedroom_play_cutscene",Callable(self,"_on_bedroom_play_cutscene"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_bedroom_play_cutscene(sceneNum):
	match sceneNum:
		"0-0":
			scene_0_0()
			pass


func _on_timer_timeout() -> void:
	EventBus.emit_signal("bedroom_play_cutscene","0-0")
	pass # Replace with function body.

func scene_0_0():
	EventBus.emit_signal("change_desk_light",false)
	EventBus.emit_signal("change_main_light",false)
	EventBus.emit_signal("change_sleep_light",false)
	EventBus.emit_signal("change_logo_light",true)
	EventBus.emit_signal("change_bathroom_light",false)
	Globle.player_movement_lcok=true
	await talk_and_wait("wake_ifrit")
	await play_and_wait("wake_ifrit_0")
	EventBus.emit_signal("change_desk_light",true)
	await talk_and_wait("wake_ifrit_0")
	await play_and_wait("wake ifrit_1")
	EventBus.emit_signal("change_sleep_light",true)


func talk_and_wait(name):
	balloon.start(resource,name)
	await DialogueManager.dialogue_finished
func play_and_wait(name):
	aniplayer.play(name)
	await aniplayer.animation_finished
