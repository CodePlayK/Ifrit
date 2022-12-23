extends PointLight2D
@onready var animator =$"AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_bedroom_change_background_light(state) -> void:
	if state:
		animator.play()
	else:
		animator.stop()
		energy=0.05
	pass # Replace with function body.
