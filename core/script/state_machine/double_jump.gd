extends JumpState

func enter() -> void:
	if !is_on_ladder():
		super.enter()

func pre_physics_process(delta)->BaseState:
	if is_on_ladder():
		return Globle.last_state
	return null
