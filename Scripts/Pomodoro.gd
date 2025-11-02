extends Node

@onready var settings

@export var win_sprite: Sprite2D
@export var start: TextureButton
@export var skip: TextureButton
@export var timer: RichTextLabel

var timer_active: bool = false
var time: float = 0

var work_time: int 
var break_time: int 
@onready var mode = modes.WORK
enum modes {WORK, BREAK}

@export var start_sprite_n: Texture2D
@export var start_sprite_h: Texture2D
@export var pause_sprite_n: Texture2D
@export var pause_sprite_h: Texture2D
@export var work_texture: Texture2D
@export var break_texture: Texture2D

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

func set_mode(new_mode):
	mode = new_mode

	toggle_timer(false)

	if mode == modes.WORK:
		time = work_time
		win_sprite.texture = work_texture
	else:
		time = break_time
		win_sprite.texture = break_texture

	update_timer()


func switch_mode():
	if mode == modes.WORK:
		set_mode(modes.BREAK)
	else:
		set_mode(modes.WORK)

func toggle_timer(on: bool):
	if on:
		start.texture_normal = pause_sprite_n
		start.texture_hover = pause_sprite_h
		timer_active = true
	else:
		start.texture_normal = start_sprite_n
		start.texture_hover = start_sprite_h
		timer_active = false	


func _ready():
	await get_tree().process_frame
	settings = $"../Settings"
	work_time = settings.player_prefs["work_time"]
	break_time = settings.player_prefs["break_time"]
	time = work_time
	set_mode(modes.WORK)

func _process(delta):
	if not timer_active:
		return

	time -= delta
	update_timer()

	if timer.text == "00:00:00":
		switch_mode()

func _on_play_pressed():
	if not timer_active:
		toggle_timer(true)
	else:
		toggle_timer(false)

func _on_skip_pressed():
	if timer_active:
		switch_mode()

func _on_visibility_changed():
	work_time = settings.player_prefs["work_time"] * 60
	break_time = settings.player_prefs["break_time"] * 60
	set_mode(modes.WORK)