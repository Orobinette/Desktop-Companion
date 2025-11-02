extends Node

var save_file_name: String = "player_prefs"

@onready var main_win = $'..'.get_window()
@onready var dialogue_manager = $'../Dialogue manager'

@export var name_input: LineEdit
@export var work_time_input: LineEdit
@export var break_time_input: LineEdit

var default_prefs = {
	"version" = 0.0,
	"name" = "Chad",
	"work_time" = 25,
	"break_time" = 5,
}
var player_prefs = {}

func _init():
	load_prefs()
	if !player_prefs.has("version") or default_prefs["version"] != player_prefs.version:
		update_save_data()

func _ready():
	name_input.text = str(player_prefs["name"])
	work_time_input.text = str(player_prefs["work_time"])
	break_time_input.text = str(player_prefs["break_time"])
	main_win.title = name_input.text

func save_prefs():
	var save_file = FileAccess.open(save_file_name, FileAccess.WRITE)
	var data = JSON.stringify(player_prefs)
	save_file.store_line(data)

func load_prefs():
	if not FileAccess.file_exists(save_file_name):
		load_default_prefs()
		return

	var save_file = FileAccess.open(save_file_name, FileAccess.READ)
	var data = save_file.get_line()
	var json = JSON.new()

	var parse_result = json.parse(data)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", data, " at line ", json.get_error_line())
		return

	player_prefs = json.get_data()

func load_default_prefs():
	player_prefs = default_prefs
	save_prefs()

func update_save_data():
	player_prefs.merge(default_prefs, true)
	save_prefs()

func _on_pomo_work_time_text_changed(new_text:String):
	player_prefs["work_time"] = int(new_text)
	save_prefs()

func _on_pomo_break_time_text_changed(new_text:String):
	player_prefs["break_time"] = int(new_text)
	save_prefs()

func _on_name_input_text_changed(txt:String):
	main_win.title = txt
	player_prefs["name"] = txt
	save_prefs()