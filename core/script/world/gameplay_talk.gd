extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#手动循环已获得动画结束信号
func _on_animation_finished(anim_name: StringName) -> void:
	play("normal")
	pass
