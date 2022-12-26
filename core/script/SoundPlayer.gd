extends Node


const player_jump_sound:Resource=preload("res://core/resource/sound/jump.wav")
const player_hurt_sound:Resource=preload("res://core/resource/sound/hurt.wav")
const player_death_sound:Resource=preload("res://core/resource/sound/death.wav")

@onready var audioPlayers: =$"AudioPlayers"

func play_sound(sound):
	for audioStreamPlayer in audioPlayers.get_children():
			if not audioStreamPlayer.playing:
				audioStreamPlayer.stream = sound
				audioStreamPlayer.play()
				break
