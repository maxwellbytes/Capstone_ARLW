extends Control

@onready var menu = $menu

var yes_region = Rect2(0, 0, 190, 111)
var no_region = Rect2(190, 0, 190, 111)

var is_yes = true
signal save_exit(icon_name: String)
signal save_initiate(curr_scene: StringName)

func _ready() -> void:
	menu.texture.region = yes_region

func _input(event: InputEvent) -> void:
	if GameManager.curr_view != 'SAVE':
		return
	if Input.is_action_just_pressed('move_forward') or Input.is_action_just_pressed('move_back'):
		is_yes = !is_yes
		update_region()
		get_viewport().set_input_as_handled()
	if Input.is_action_just_pressed("ui_accept"):
		if is_yes:
			var curr_scene = get_tree().current_scene.name
			#save_initiate.emit(curr_scene)
			SaveSystem.save_game()
			#GameManager.curr_view = ''
			get_tree().change_scene_to_file("res://UI/main_menu.tscn")
			#SaveSystem.save_game($Player, get_tree().current_scene.scene_file_path, door_opened)
			# add smth to indicate game has been saved if i have time
		else:
			save_exit.emit('HOME')
			get_viewport().set_input_as_handled()
			
func update_region():
	if is_yes:
		menu.texture.region = yes_region
	else:
		menu.texture.region = no_region
