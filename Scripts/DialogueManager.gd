extends Node

var pomo
var todo
var settings

var dialogue = {
	"open": [
		"Hey",
		"What's up bro?",
	],
	"pomodoro_work_start": [
		"Lets work our mind to failure",
		"I wanna see slow and controlled focus",
		"Time to exercise our mind",
		"Lock in bro",
		"I got some pre if you need bro"
	],
	"pomodoro_break_start": [
		"Rest is important for growth",
		"Set's over dude",
		"Kick back bro"
	],
	"todo_check": [
		"Feels good",
	],
	"new_name": [
		"I dig it",
		"Sweet",
		"Good pick bro",
	],
}	

@onready var dialogue_box_path = preload("res://Scenes/scn_bubble.tscn")

func spawn_dialogue(text):
	var box = dialogue_box_path.instantiate()
	box.text.text = text
	add_child(box)

func _ready():
	await get_tree().process_frame

	pomo = $'../Pomodoro timer'
	todo = $'../Todo'
	settings = $'../Settings'

	settings.name_input.text_submitted.connect(_on_name_input_text_changed)
	pomo.break_start.connect(_on_break_start)
	pomo.work_start.connect(_on_work_start)
	todo.check.connect(_on_todo_check)

	spawn_dialogue(dialogue["open"][randi_range(0, dialogue["open"].size()-1)])

func _on_name_input_text_changed(_txt:String):
	spawn_dialogue(dialogue["new_name"][randi_range(0, dialogue["new_name"].size()-1)])

func _on_break_start():
	spawn_dialogue(dialogue["pomodoro_break_start"][randi_range(0, dialogue["pomodoro_break_start"].size()-1)])

func _on_work_start():
	spawn_dialogue(dialogue["pomodoro_work_start"][randi_range(0, dialogue["pomodoro_work_start"].size()-1)])

func _on_todo_check():
	if randi_range(1, 3) == 1:
		spawn_dialogue(dialogue["todo_check"][randi_range(0, dialogue["todo_check"].size()-1)])
	