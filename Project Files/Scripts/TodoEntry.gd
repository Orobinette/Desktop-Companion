extends Node

@onready var win = $"../../.."

@export var check: CheckBox
@export var text_box: RichTextLabel
@export var delete: TextureButton

var text: String

func _ready():
	text = text_box.text

func _on_check_pressed(on):
	if on:
		text_box.text = str("[s]", text, "[/s]")
		win.check.emit()
		Sfx.play_audio("check")
	else:
		text_box.text = text


func _on_delete_button_pressed():
	Sfx.play_audio("erase_todo")
	queue_free()