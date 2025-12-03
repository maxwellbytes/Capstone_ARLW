extends Node

const SAVE_PATH = "user://saves/save_file.cfg"

var door_opened: bool = false
var player: Node = null
var pending_save_data: Dictionary = {}

func _ready():
	ensure_save_directory()

func ensure_save_directory() -> void:
	var dir = DirAccess.open("user://")
	if dir:
		if not dir.dir_exists("saves"):
			var error = dir.make_dir("saves")
			if error != OK:
				print("something wrong with the save file: ", error)

func save_game() -> void:
	var config = ConfigFile.new()
	# current_scene_path: String
	
	config.set_value("inventory", "key", ItemDatabase.item_list['key'].in_inv)
	config.set_value("inventory", "rb", ItemDatabase.item_list['rb'].in_inv)
	#config.set_value("inventory", "chips", ItemDatabase.item_list['chips'].in_inv)
	#config.set_value("inventory", "crackers", ItemDatabase.item_list['crackers'].in_inv)
	
	config.set_value("player", "x", player.position.x)
	config.set_value("player", "y", player.position.y)
	config.set_value("player", "z", player.position.z)
	
	config.set_value("game_state", "curr_scene", get_tree().current_scene.scene_file_path)
	#config.set_value("game_state", "current_scene", current_scene_path)
	config.set_value("game_state", "door_opened", door_opened)
	
	config.save(SAVE_PATH)
	
func load_game() -> Dictionary:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)

	ItemDatabase.item_list['key'].in_inv = config.get_value("inventory", "key", false)
	ItemDatabase.item_list['rb'].in_inv = config.get_value("inventory", "rb", false)
	#ItemDatabase.item_list['chips'].in_inv = config.get_value("inventory", "chips", false)
	#ItemDatabase.item_list['crackers'].in_inv = config.get_value("inventory", "crackers", false)
	
	return {
		"player_pos": Vector3(
			config.get_value("player", "x", 0.0),
			config.get_value("player", "y", 0.0),
			config.get_value("player", "z", 0.0)
		),
		"curr_scene": config.get_value("game_state", "curr_scene", ""),
		"door_opened": config.get_value("game_state", "door_opened", false)
	}
