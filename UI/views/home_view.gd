extends Control

#var ViewDictionary = preload("res://UI/scripts/view_dictionary.gd")
#var view_dict_instance

#@onready var curr_icon = null
const ViewDictionary = preload("res://UI/scripts/view_dictionary.gd")
var curr_icon: View
signal icon_selected(icon_name: String)

@onready var files_texture = $GridContainer/files
@onready var camera_texture = $GridContainer/camera
@onready var gallery_texture = $GridContainer/gallery
@onready var save_texture = $GridContainer/save
@onready var settings_texture = $GridContainer/settings
@onready var gps_texture = $GridContainer/gps

#var region_dict: Dictionary = {}
#const item = preload("res://scripts/item.gd")
#var item_list: Dictionary = {}

func _ready():
	#process_mode = Node.PROCESS_MODE_ALWAYS
	ViewDictionary.load()
	#load menu with files icon selected by default
	curr_icon = ViewDictionary.view_dict["FILES"]
	files_texture.texture.region = curr_icon.select_region
	#PauseEventBus.icon_selected.connect(change_view)
	#view_dict_instance = ViewDictionary.new()
	#curr_icon = view_dict_instance.view_dict["HOME"]

#func change_view():
	#print("change view")
	#GameManager.open_view(curr_icon.name)

func set_icon(new_icon: View):
	var prev_icon = curr_icon
	#print(prev_icon.name)
	
	match prev_icon.name:
		"FILES":
			#print("test")
			files_texture.texture.region = prev_icon.atlas_region
		"CAMERA":
			camera_texture.texture.region = prev_icon.atlas_region
		"GALLERY":
			gallery_texture.texture.region = prev_icon.atlas_region
		"SAVE":
			save_texture.texture.region = prev_icon.atlas_region
		"SETTINGS":
			settings_texture.texture.region = prev_icon.atlas_region
		"GPS":
			gps_texture.texture.region = prev_icon.atlas_region
	match new_icon.name:
		"FILES":
			files_texture.texture.region = new_icon.select_region
		"CAMERA":
			camera_texture.texture.region = new_icon.select_region
		"GALLERY":
			gallery_texture.texture.region = new_icon.select_region
		"SAVE":
			save_texture.texture.region = new_icon.select_region
		"SETTINGS":
			settings_texture.texture.region = new_icon.select_region
		"GPS":
			gps_texture.texture.region = new_icon.select_region
	curr_icon = new_icon
	
	#curr_icon.texture.region = new_icon.select_region
	#idk if this will change the atlas region

# does _input check every frame?? is this method called when it has been hidden and the player is moving?
func _input(event: InputEvent) -> void:
	if GameManager.in_app and GameManager.is_paused:
		if Input.is_action_just_pressed("ui_accept"):
			icon_selected.emit("HOME")
	else:
		if Input.is_action_just_pressed("ui_accept") and GameManager.curr_view == "HOME":
			icon_selected.emit(curr_icon.name)
			#print('input getting tripped')
		if Input.is_action_just_pressed("move_right") and GameManager.curr_view == "HOME":
			next_icon("RIGHT")
		if Input.is_action_just_pressed("move_left") and GameManager.curr_view == "HOME":
			next_icon("LEFT")
		if Input.is_action_just_pressed("move_forward") and GameManager.curr_view == "HOME":
			next_icon("UP")
		if Input.is_action_just_pressed("move_back") and GameManager.curr_view == "HOME":
			next_icon("DOWN")

#should probably remove the match and replace it with an array and an access index
func next_icon(direction: String):
	#add 1 to index unless number is max, go back to original number
	#print(direction)
	match direction:
		"RIGHT":
			#var new_icon = curr_icon.right
			set_icon(ViewDictionary.view_dict[curr_icon.right])
		"LEFT":
			set_icon(ViewDictionary.view_dict[curr_icon.left])
		"UP":
			set_icon(ViewDictionary.view_dict[curr_icon.up])
		"DOWN":
			set_icon(ViewDictionary.view_dict[curr_icon.down])
	pass
