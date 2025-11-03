extends Window

@onready var settings

@export var win_sprite: Sprite2D
@export var start: TextureButton
@export var skip: TextureButton
@export var timer: RichTextLabel

var timer_active: bool = false
var time: float = 0

var work_time: int 
var break_time: int 
@onready var phase = phases.WORK
enum phases {WORK, BREAK}

@export var start_sprite_n: Texture2D
@export var start_sprite_h: Texture2D
@export var pause_sprite_n: Texture2D
@export var pause_sprite_h: Texture2D
@export var work_texture: Texture2D
@export var break_texture: Texture2D

signal work_start
signal break_start

func update_timer():
	var hour = int(time/60/60)
	var minutes = int(time/60 - hour * 3600)
	var sec = int(time - hour * 3600 - minutes * 60)
	if hour < 10:
		hour = str("0", hour)
	if minutes < 10:
		minutes = str("0", minutes)
	if sec < 10:
		sec = str("0", sec)

	timer.text = str(hour, ":", minutes, ":", sec)

func set_phase(new_phase):
	phase = new_phase

	toggle_timer(false)

	if phase == phases.WORK:
		time = work_time
		win_sprite.texture = work_texture
	else:
		time = break_time
		win_sprite.texture = break_texture

	update_timer()

func switch_phase():
	visible = true
	show()

	if phase == phases.WORK:
		set_phase(phases.BREAK)
	else:
		set_phase(phases.WORK)

func toggle_timer(on: bool):
	if on:
		start.texture_normal = pause_sprite_n
		start.texture_hover = pause_sprite_h
		timer_active = true
	else:
		start.texture_normal = start_sprite_n
		start.texture_hover = start_sprite_h
		timer_active = false	

func reset_time_settings():
	work_time = settings.player_prefs["work_time"] * 60
	break_time = settings.player_prefs["break_time"] * 60


func _ready():
	await get_tree().process_frame
	settings = $"../Settings"
	settings.work_time_input.text_submitted.connect(_on_time_settings_updated)
	settings.break_time_input.text_submitted.connect(_on_time_settings_updated)
	reset_time_settings()
	set_phase(phases.WORK)

func _process(delta):
	if not timer_active:
		return

	time -= delta
	update_timer()

	if timer.text == "00:00:00":
		switch_phase()

func _on_play_pressed():
	if not timer_active:
		toggle_timer(true)
		if phase == phases.WORK:
			Sfx.play_audio("work_start")
			work_start.emit()
		else:
			Sfx.play_audio("break_start")
			break_start.emit()
	else:
		toggle_timer(false)

func _on_skip_pressed():
	switch_phase()

func _on_visibility_changed():
	reset_time_settings()
	#set_phase(phases.WORK)

func _on_time_settings_updated(_text):
	reset_time_settings()

	if !timer_active:
		set_phase(phase)