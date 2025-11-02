extends AudioStreamPlayer

# "": preload(""),
var sfx = {
	"add_task": preload("res://Audio/sfx_add_task.wav"),
	"buttons_toggled": preload("res://Audio/sfx_buttons_toggled.wav"),
	"check": preload("res://Audio/sfx_check.wav"),
	"close_window": preload("res://Audio/sfx_screen_off.wav"),
	"erase_todo": preload("res://Audio/sfx_erase_todo.wav"),
	"open_window": preload("res://Audio/sfx_screen_on.wav"),
	"settings_change": preload("res://Audio/sfx_settings_change.wav"),
	"work_start": preload("res://Audio/sfx_work_start.wav"),
	"break_start": preload("res://Audio/sfx_break_start.wav"),
}

func play_audio(audio: String):
	stream = sfx[audio]
	play()