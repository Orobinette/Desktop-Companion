extends Node

@onready var win: Window = get_window()
@export var companion_button: TextureButton
@export var todo_button: TextureButton
@export var pomodoro_button: TextureButton
@export var settings_button: TextureButton
@export var close_button: TextureButton
@export var container: HBoxContainer
@export var click_timer: Timer

var buttons_on: bool = false
var dragging: bool
var offset: int

var todo_win
var pomodoro_win
var settings_win
var todo_path = load("res://Scenes/scn_todo.tscn")
var pomodoro_path = load("res://Scenes/scn_pomodoro_timer.tscn")
var settings_path = load("res://Scenes/scn_settings.tscn")

func _ready():
	win.position = DisplayServer.screen_get_usable_rect().size - get_viewport().size
	get_tree().get_root().set_transparent_background(true)
	get_viewport().set_embedding_subwindows(false)

	todo_win = todo_path.instantiate()
	todo_win.visible = false
	add_child(todo_win)
	close_todo()
	todo_win.close_requested.connect(close_todo)

	pomodoro_win = pomodoro_path.instantiate()
	pomodoro_win.visible = false
	add_child(pomodoro_win)
	close_pomodoro()
	pomodoro_win.close_requested.connect(close_pomodoro)

	settings_win = settings_path.instantiate()
	settings_win.visible = false
	add_child(settings_win)
	close_pomodoro()
	settings_win.close_requested.connect(close_settings)

func _process(_delta):
	if Input.is_action_just_pressed("interact"): # Initial press
		offset = win.position.x - DisplayServer.mouse_get_position().x
		click_timer.start(0.05)
	elif Input.is_action_just_released("interact") and !click_timer.is_stopped(): # Left Click
		print("click")
	elif Input.is_action_pressed("interact") and click_timer.is_stopped(): # Left Drag
		win.position.x = DisplayServer.mouse_get_position().x + offset
	
	if Input.is_action_just_pressed("open_quick_menu"): # Right click
		toggle_buttons()

func toggle_buttons():
	buttons_on = !buttons_on

	if buttons_on:
		container.process_mode = PROCESS_MODE_INHERIT
		container.visible = true
	else:
		container.process_mode = PROCESS_MODE_DISABLED
		container.visible = false

func _on_todo_pressed():
	open_todo()

func _on_pomodoro_pressed():
	open_pomodoro()

func _on_settings_pressed():
	open_settings()

func open_todo():
	todo_win.visible = true
	todo_win.show()

func close_todo():
	todo_win.hide()

func open_pomodoro():
	pomodoro_win.visible = true
	pomodoro_win.show()

func close_pomodoro():
	pomodoro_win.hide()

func open_settings():
	settings_win.visible = true
	settings_win.show()

func close_settings():
	settings_win.hide()

func _on_close_pressed():
	get_tree().quit()