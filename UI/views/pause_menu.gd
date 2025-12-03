extends Control

#@onready var curr_view = $ScreenArea/HomeView
# 10/20 do i need this or can i reference it directly??
# nvm i forgot it was to connect the signals lol
# nvm x2 i can just reference it directly? that might be bad idk
#@onready var game_manager = get_node("/root/GameManager")
#var home_view = preload("res://UI/views/home_view.gd")
#signal icon_selected(icon_name: String)
@onready var home_view = $ScreenArea/HomeView
@onready var file_view = $ScreenArea/fileView
@onready var save_view = $ScreenArea/SaveView

signal now_visible

#enum View {HOME, FILES, CAMERA, GALLERY, SAVE, SETTINGS, GPS}
#var open: bool = false
#func _unhandled_input(event):
	#if Input.is_action_pressed("move_right"):
		#curr_view.next_icon("right")
	#if Input.is_action_pressed("move_left"):
		#curr_view.next_icon()
	#if (Input.is_action_pressed("move_back") || Input.is_action_pressed("move_forward")):
		#curr_view.next_row()
	#

func _ready() -> void:
	#GameManager.is_inventory_open.connect(isOpen())
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
	GameManager.menu_toggled.connect(on_menu_toggle)
	GameManager.view_changed.connect(on_view_change)
	home_view.icon_selected.connect(change_view)
	file_view.file_exit.connect(change_view)
	save_view.save_exit.connect(change_view)

func change_view(icon_name: String):
	GameManager.open_view(icon_name)

func on_menu_toggle(is_paused):
	visible = is_paused

func on_view_change(view_name: String):
	print(view_name)
	#hide all views
	
	#just changed this 11/3, nothing seemed to change but might cause issues down the line
	#trying to get buttons to show for files scene
	#for child in $ScreenArea.get_children():
		#child.hide()
	if view_name == "":
		#hide()
		home_view.show()
	# if i have time i should move the show/hide to a helper method
	match view_name:
		"HOME":
			file_view.hide()
			file_view.process_mode = Node.PROCESS_MODE_DISABLED
			save_view.hide()
			save_view.process_mode = Node.PROCESS_MODE_DISABLED
			
			home_view.show()
			home_view.process_mode = Node.PROCESS_MODE_ALWAYS
		"FILES":
			home_view.hide()
			home_view.process_mode = Node.PROCESS_MODE_DISABLED
			save_view.hide()
			save_view.process_mode = Node.PROCESS_MODE_DISABLED
			
			file_view.show()
			file_view.process_mode = Node.PROCESS_MODE_ALWAYS
			now_visible.emit()
		"SAVE":
			home_view.hide()
			file_view.hide()
			home_view.process_mode = Node.PROCESS_MODE_DISABLED
			file_view.process_mode = Node.PROCESS_MODE_DISABLED
			save_view.show()
			save_view.process_mode = Node.PROCESS_MODE_ALWAYS
			

	#if view_name == "":
		#hide()
	#else:
		#show()

#func _unhandled_input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#print("unhandled")

func _input(event):
	#print(GameManager.is_paused)
	if event.is_action_pressed("pause"):
		GameManager.toggle_pause()
	#elif event.is_action_pressed("ui_accept") and GameManager.is_paused:
		##print("test1")
		##if on the homescreen use the name of the current icon
		#if home_view.visible:
				#var view_name = home_view.curr_icon.name
				#GameManager.open_view(view_name)
		
