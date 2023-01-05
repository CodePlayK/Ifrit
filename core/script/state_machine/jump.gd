class_name JumpState
extends BaseState
func enter() -> void:
	super.enter()
	SoundPlayer.play_sound(SoundPlayer.player_jump_sound)

func physics_process(delta: float) -> BaseState:
	move=get_movement_input_x()
	player_faced(move)
	apply_gravity(delta)
	apply_acceleration_walk(move,delta)
	player.set_up_direction(Vector2.UP)
	player.velocity.y = -player.jump_speed
	player.move_and_slide()
	if is_on_ladder():
		return climb_state
	if player.is_on_floor():
		if move != 0:
			if Input.is_action_pressed("run"):
				return run_state
			return walk_state
		return idle_state
	else:
		if player.velocity.y > 0:
			return fall_state
		else:
			return lift_state
