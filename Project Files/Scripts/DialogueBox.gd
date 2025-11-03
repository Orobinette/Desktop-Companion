extends Node

@export var timer: Timer
@export var text: RichTextLabel

func _ready():
	text.set_visible_characters(0)

	await get_tree().create_timer(0.2).timeout
	timer.set_process_mode(PROCESS_MODE_INHERIT)


func _on_timer_timeout():
	if text.get_visible_characters() < text.text.length():
		text.set_visible_characters(text.get_visible_characters() + 1) 
	else:
		await get_tree().create_timer(2).timeout
		queue_free()