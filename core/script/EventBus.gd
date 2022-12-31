extends Node
signal player_is_dead
signal change_state_ui
signal player_enter_bathroom()
signal player_leave_bathroom()
signal change_main_light(state)
signal change_sleep_light(state)
signal change_logo_light(state)
signal change_desk_light(state)
signal change_background_light(state)
signal change_bathroom_light(state)
signal change_bathroom_light_enegy(state)
signal change_worldEnvironment_exposure_white(expose,white)
signal change_mirror(state)
signal change_mirror_mix_value(state)
signal change_heighlight(state)
signal change_flames(routate_range:Vector2,wave_speed,line,y_scale,color,layer_name,wave_center_color,routate_speed)
signal burst_flame_wave(burst_setting)

func _ready():
	pass

