extends Node2D

@export var companion_button: Button
@export var todo_button: Button
@export var pomodoro_button: Button
@export var settings_button: Button
@export var close_button: Button
@export var container: VBoxContainer

var todo_win
var pomodoro_win

func _ready():
	get_tree().get_root().set_transparent_background(true)
	get_viewport().set_embedding_subwindows(false)

	todo_win = Window.new()
	todo_win.visible = false
	add_child(todo_win)
	close_todo()
	todo_win.size = Vector2(300, 200)
	todo_win.position = Vector2(10, 50)
	todo_win.title = "Todo"
	todo_win.close_requested.connect(close_todo)

	pomodoro_win = Window.new()
	pomodoro_win.visible = false
	add_child(pomodoro_win)
	close_pomodoro()
	pomodoro_win.size = Vector2(300, 200)
	pomodoro_win.position = Vector2(10, 50)
	pomodoro_win.title = "Pomodoro"
	pomodoro_win.close_requested.connect(close_pomodoro)

func _on_companion_button_toggled(on: bool):
	if on:
		container.process_mode = PROCESS_MODE_INHERIT
		container.visible = true
	else:
		container.process_mode = PROCESS_MODE_DISABLED
		container.visible = false

func _on_todo_pressed():
	open_todo()

func _on_pomodoro_pressed():
	todo_win.visible = true
	open_pomodoro()

func open_todo():
	todo_win.show()

func close_todo():
	todo_win.hide()

func open_pomodoro():
	pomodoro_win.visible = true
	pomodoro_win.show()

func close_pomodoro():
	pomodoro_win.hide()


func _on_close_pressed():
	get_tree().quit()