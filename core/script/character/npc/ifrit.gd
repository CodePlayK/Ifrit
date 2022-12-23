extends CharacterBody2D
@onready var balloon=$Balloon
@onready var resource=preload("res://core/dialog/test1.dialogue")

var player_entered:bool=false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()


func _on_player_checker_body_entered(body: Node2D) -> void:
		if balloon.is_talking:
			balloon.show()
		else:
			balloon.start(resource,"start")


func _on_player_checker_body_exited(body: Node2D) -> void:
		balloon.hide()


