class_name AirState
extends BaseState


func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump") and Globle.double_jump_flag:
		Globle.double_jump_flag=false
		return double_jump_state
	return null


func physics_process(delta: float) -> BaseState:
	if is_on_ladder() and Input.is_action_pressed("jump"):
		return climb_state
	move=get_movement_input_x()
	player_faced(move)
	apply_gravity(delta)
	apply_acceleration_run(move,delta)
	player.set_velocity(player.velocity)
	player.set_up_direction(Vector2.UP)
	player.move_and_slide()
	player.velocity=min_jump_force(player.velocity,delta)
	if player.is_on_floor():
		return landing_state
	else:
		if player.velocity.y>0:
			return fall_state
	return null
