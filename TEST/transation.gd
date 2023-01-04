extends Control
@onready var screenshot=$"%screenshot"
@onready var camera=$"%Camera2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func get_screenshot() -> ImageTexture:
	#RenderingServer.viewport_set_clear_mode(get_viewport().get_viewport_rid(),2)
	# Wait until the frame has finished before getting the texture.
	var img = camera.get_viewport().get_texture().get_image()
	img.save_png("res://TEST/screenshot/stuff.png")
	return ImageTexture.create_from_image(img)


func _on_timer_timeout() -> void:
	screenshot.set_texture(get_screenshot())
	pass
