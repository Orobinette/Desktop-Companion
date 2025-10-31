extends Node

@onready var settings

@export var start: TextureButton
@export var skip: TextureButton
@export var timer: RichTextLabel

var timer_active: bool = false
var time: float = 0

var work_time: int = 5
var break_time: int = 10
@onready var mode = modes.WORK
enum modes {WORK, BREAK}

@export var start_sprite_n: Texture2D
@export var start_sprite_h: Texture2D
@export var pause_sprite_n: Texture2D
@export var pause_sprite_h: Texture2D

func _ready():
	print("br")
	time = work_time
	update_timer()
	await get_tree().process_frame
	settings = $"../Settings"

func update_timer():
	var hour = int(time/60/60)
	var min = int(time/60 - hour * 3600)
	var sec = int(time - hour * 3600 - min * 60)
	if hour < 10:
		hour = str("0", hour)
	if min < 10:
		min = str("0", min)
	if sec < 10:
		sec = str("0", sec)

	timer.text = str(hour, ":", min, ":", sec)

func _on_start():
	if not timer_active:
		toggle_timer(true)
	else:
		toggle_timer(false)

func toggle_timer(on: bool):
	if on:
		start.texture_normal = pause_sprite_n
		start.texture_hover = pause_sprite_h
		timer_active = true
	else:
		start.texture_normal = start_sprite_n
		start.texture_hover = start_sprite_h
		timer_active = false	

func _process(delta):
	if not timer_active:
		return

	time -= delta
	update_timer()

	if timer.text == "00:00:00":
		switch_mode()

func switch_mode():
	toggle_timer(false)

	if mode == modes.WORK:
		mode = modes.BREAK
		time = break_time
	else:
		mode = modes.WORK
		time = work_time

	update_timer()

func _on_skip_pressed():
	if timer_active:
		switch_mode()

func _on_visibility_changed():
	work_time = settings.work_time
	break_time = settings.break_time
	update_timer()