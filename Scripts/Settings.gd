extends Node

@export var work_time_input: LineEdit
@export var break_time_input: LineEdit

var work_time: int = 25
var break_time: int = 5


func _on_pomo_work_time_text_changed(new_text:String):
	work_time = int(new_text)

func _on_pomo_break_time_text_changed(new_text:String):
	break_time = int(new_text)
