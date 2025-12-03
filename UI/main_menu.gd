extends Control

@onready var menu = $menu

var new_region = Rect2(0, 0, 480, 270)
var load_region = Rect2(480, 0, 480, 270)
var exit_region = Rect2(960, 0, 480, 270)

var curr_index = 0

func _ready() -> void:
	menu.texture.region = new_region
	GameManager.is_paused = false
	GameManager.curr_view = ''
	get_tree().paused = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed('move_forward'):
		cycle_display(-1)
	if Input.is_action_just_pressed('move_back'):
		cycle_display(1)
	if Input.is_action_just_pressed('ui_accept'):
		match curr_index:
			0:
				get_tree().change_scene_to_file("res://outside.tscn")
			1:
				load_save()
			2:
				get_tree().quit()

func update_display():
	match curr_index:
		0:
			menu.texture.region = new_region
		1:
			menu.texture.region = load_region
		2:
			menu.texture.region = exit_region

func cycle_display(direction: int):
	if direction > 0:
		if curr_index == 2:
			curr_index = 0
		else:
			curr_index = curr_index + 1
	elif direction < 0:
		if curr_index == 0:
			curr_index = 2
		else:
			curr_index = curr_index - 1
	update_display()

func load_save():
	var save_data = SaveSystem.load_game()
	
	if save_data.has("curr_scene") and save_data["curr_scene"] != "":
		SaveSystem.pending_save_data = save_data
		get_tree().change_scene_to_file(save_data["curr_scene"])
