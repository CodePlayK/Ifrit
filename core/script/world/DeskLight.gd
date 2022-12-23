extends PointLight2D
@onready var balloon = $"%Balloon"
@onready var mainLight = $"%MainLight"
@onready var resource=preload("res://core/dialog/test1.dialogue")
var on_player:bool=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interactive") and on_player:
		if mainLight.visible:
			pass
		else :
			visible=true
	pass


func _on_bedroom_change_desk_light(state) -> void:
	visible=state
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	on_player=true
	balloon.start(resource,"on_desk_light")
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	on_player=false
	balloon.hide()
	pass # Replace with function body.
