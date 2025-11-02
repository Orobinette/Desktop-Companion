extends Node

@export var text_input: LineEdit
@export var entry_container: VBoxContainer

var todo_entry_path = preload("res://Scenes/scn_todo_entry.tscn")

signal check

func add():
	if text_input.text.length() == 0:
		return

	var todo_entry = todo_entry_path.instantiate()
	todo_entry.text_box.text = text_input.text
	entry_container.add_child(todo_entry)

	text_input.text = ""


func _on_add_button_pressed():
	add()

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		add()