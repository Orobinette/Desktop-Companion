extends Node

@export var check: CheckBox
@export var text_box: RichTextLabel
@export var delete: Button

var text: String

func _ready():
	text = text_box.text

func _on_check_pressed(on):
	if on:
		text_box.text = str("[s]", text, "[/s]")
	else:
		text_box.text = text

func _on_delete_button_pressed():
	queue_free()