extends Area2D
@onready var resource=preload("res://core/dialog/test1.dialogue")
@onready var balloon=$"%Balloon"
var on_player:bool=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


	#is_reset_player_position()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_player&&!Globle.playing_cutscene:
		if Input.is_action_just_pressed("interactive"):
			Globle.player_movement_lcok=true
			#await get_tree().create_timer(3).timeout
			on_player=false
			#await DialogueManager.dialogue_finished
			EventBus.emit_signal("bedroom_play_cutscene","0_0")
	pass


func _on_body_entered(body: Node2D) -> void:
	if Globle.playing_cutscene||Globle.player_movement_lcok:
		return
	on_player=true
	balloon.start(resource,"play_cutscene")
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	if Globle.playing_cutscene||Globle.player_movement_lcok:
		return
	balloon.hide()
	on_player=false
	pass # Replace with function body.
