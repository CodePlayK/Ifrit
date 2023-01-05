extends Node
@onready var balloon=$"%Balloon"
@onready var aniplayer=$aniplayer
@onready var ifrit=%ifrit
@onready var player=%Player
@onready var doctor=%doctor
@onready var resource=preload("res://core/dialog/cutscene/0_0_bedroom.dialogue")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("bedroom_play_cutscene",Callable(self,"_on_bedroom_play_cutscene"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_bedroom_play_cutscene(sceneNum):
	Globle.current_cutscene=sceneNum
	Globle.playing_cutscene=true
	match sceneNum:
		"0_0":
			cutscene_started($"0_0_camera_start")
			await scene_0_0()
			cutscene_finished($"0_0_palyer_end")
			pass
	Globle.playing_cutscene=false

func _on_timer_timeout() -> void:
	EventBus.emit_signal("bedroom_play_cutscene","0_0")
	pass # Replace with function body.

func scene_0_0():
	doctor.hide()
	ifrit.set_animation("empty")
	EventBus.emit_signal("change_desk_light",false)
	EventBus.emit_signal("change_main_light",false)
	EventBus.emit_signal("change_sleep_light",false)
	EventBus.emit_signal("change_logo_light",true)
	EventBus.emit_signal("change_bathroom_light",false)
	Globle.player_movement_lcok=true
	await talk_and_wait("wake_ifrit",1)
	await play_and_wait("wake_ifrit_0",1)
	EventBus.emit_signal("change_desk_light",true)
	await wait(1)
	await talk_and_wait("wake_ifrit_0",1)
	await play_and_wait("wake_ifrit_1",1)
	EventBus.emit_signal("change_sleep_light",true)
	await wait(1)
	await play_and_wait("wake_ifrit_2",1)
	await talk_and_wait("wake_ifrit_1",1)
	ifrit.set_animation("wake_mad")
	await wait(3)
	ifrit.set_animation("empty")
	Globle.player_movement_lcok=false
func talk_and_wait(ani_name,time):
	balloon.start(resource,ani_name)
	await DialogueManager.dialogue_finished
	await get_tree().create_timer(time).timeout
func play_and_wait(ani_name,time):
	aniplayer.play(ani_name)
	await aniplayer.animation_finished
	await get_tree().create_timer(time).timeout
func wait(time):
	await get_tree().create_timer(time).timeout
func cutscene_finished(marker):
	EventBus.emit_signal("change_player_position",Vector2( marker.get_position().x,player.get_position().y))
	EventBus.emit_signal("change_player_visiable",true)
func cutscene_started(marker):
	EventBus.emit_signal("change_player_position",Vector2( marker.get_position().x,player.get_position().y))
	EventBus.emit_signal("change_player_visiable",false)
