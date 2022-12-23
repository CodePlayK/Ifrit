extends BaseState


func enter() -> void:
	super.enter()
	Globle.double_jump_flag=true

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	elif Input.is_action_just_pressed("dash"):
		return dash_state
	return null

func physics_process(delta: float) -> BaseState:
	move=get_movement_input_x()
	apply_gravity(delta)
	apply_acceleration_run(move,delta)
	player_faced(move)
	player.set_up_direction(Vector2.UP)
	player.move_and_slide()
	if !player.is_on_floor():
		if player.velocity.y<=0:
			return lift_state
		else:
			return fall_state
	return null

func after_physics_process(delta: float) -> BaseState:
	if get_movement_input_x() and !is_player_blocked():
		if Input.is_action_pressed("run"):
			return run_state
		return walk_state
	return null
