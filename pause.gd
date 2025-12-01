extends ColorRect

var pause_menu_scene = preload("res://UI/views/pause_menu.tscn")
var pause_menu_instance: Node = null
@onready var sprite = $Control
#@onready var control_tree = $Control/Control.get_children()
@onready var child_control = $Control/Control

# unsure if I need @onready for these
@onready var regionFiles: Rect2 = Rect2(0, 0, 0, 0)
@onready var regionCamera: Rect2 = Rect2(320, 0, 320, 320)
@onready var regionGallery: Rect2 = Rect2(640, 0, 640, 640)
@onready var regionSave: Rect2 = Rect2(0, 180, 0, 0)
@onready var regionSettings: Rect2 = Rect2(320, 180, 320, 320)
@onready var regionGPS: Rect2 = Rect2(640, 180, 640, 640)

signal input(regionName)
signal display
signal unpause

var curr_x = 0
var curr_y = 0
var curr_screen: String = "main"

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	$Control.hide()
	child_control.hide()
	#make it so that this node always processes and wont get paused
	#process_mode = Node.PROCESS_MODE_ALWAYS
	sprite.inv_open.connect(set_screen)
	child_control.close_menu.connect(unpause_game)
	GameManager.paused_changed.connect(on_pause_changed)

#add function that emits a signal based on key input?

func set_screen():
	curr_screen = "inv"
	print(curr_screen)

func on_pause_changed(is_paused: bool):
	if is_paused:
		$Control.show()
	else:
		$Control.hide()
		child_control.hide()
		# so that the screen opens back to main, eliminate inv_closed calls between this script?
		# still need inv_closed to switch back to main menu without closing menu
		# maybe make a window_closed in global/large script?
		# maybe make a autoload script to handle overarching menu logic? or store it in root control node
		curr_screen = "main"

func _input(event):
	if Input.is_action_just_pressed("pause"):
		if GameManager.is_paused:
			if GameManager.curr_view == "inventory":
				# return to main pause menu
				GameManager.set_view("home")
			else:
				GameManager.toggle_pause()
		else:
			GameManager.toggle_pause()

func _nav_pause_menu(event):
	# files/camera/gallery
	if curr_y == 0:
		# do smth other than a match statement please
		match curr_x:
			# files
			0:
				if Input.is_action_just_pressed("move_left"):
					input.emit("gallery")
					curr_x = 2
				if Input.is_action_just_pressed("move_right"):
					input.emit("camera")
					curr_x = 1
				# merge these 2 in to 1 if statement. too tired rn 10/10/25
				if Input.is_action_just_pressed("move_forward"):
					#sprite._set_frame(regionSave)
					input.emit("save")
					curr_y = 1
				if Input.is_action_just_pressed("move_back"):
					input.emit("save")
					curr_y = 1
			# camera
			1:
				if Input.is_action_just_pressed("move_left"):
					input.emit("files")
					curr_x = 0
				if Input.is_action_just_pressed("move_right"):
					input.emit("gallery")
					curr_x = 2
				# merge these 2 in to 1 if statement. too tired rn 10/10/25
				if Input.is_action_just_pressed("move_forward"):
					input.emit("settings")
					curr_y = 1
				if Input.is_action_just_pressed("move_back"):
					input.emit("settings")
					curr_y = 1
			# gallery
			2:
				if Input.is_action_just_pressed("move_left"):
					input.emit("camera")
					curr_x = 1
				if Input.is_action_just_pressed("move_right"):
					input.emit("files")
					curr_x = 0
				# merge these 2 in to 1 if statement. too tired rn 10/10/25
				if Input.is_action_just_pressed("move_forward"):
					input.emit("GPS")
					curr_y = 1
				if Input.is_action_just_pressed("move_back"):
					input.emit("GPS")
					curr_y = 1
		
	# save/settings/gps
	elif curr_y == 1:
		# ditto as last match statement
		match curr_x:
			# save
			0:
				if Input.is_action_just_pressed("move_left"):
					input.emit("GPS")
					curr_x = 2
				if Input.is_action_just_pressed("move_right"):
					input.emit("settings")
					curr_x = 1
				# merge these 2 in to 1 if statement. too tired rn 10/10/25
				if Input.is_action_just_pressed("move_forward"):
					input.emit("files")
					curr_y = 0
				if Input.is_action_just_pressed("move_back"):
					input.emit("files")
					curr_y = 0
			# settings
			1:
				if Input.is_action_just_pressed("move_left"):
					input.emit("save")
					curr_x = 0
				if Input.is_action_just_pressed("move_right"):
					input.emit("GPS")
					curr_x = 2
				# merge these 2 in to 1 if statement. too tired rn 10/10/25
				if Input.is_action_just_pressed("move_forward"):
					input.emit("camera")
					curr_y = 0
				if Input.is_action_just_pressed("move_back"):
					input.emit("camera")
					curr_y = 0
			# gps
			2:
				if Input.is_action_just_pressed("move_left"):
					input.emit("settings")
					curr_x = 1
				if Input.is_action_just_pressed("move_right"):
					input.emit("save")
					curr_x = 0
				# merge these 2 in to 1 if statement. too tired rn 10/10/25
				if Input.is_action_just_pressed("move_forward"):
					input.emit("gallery")
					curr_y = 0
				if Input.is_action_just_pressed("move_back"):
					input.emit("gallery")
					curr_y = 0

func pause_game():
	print("pausing")
	get_tree().paused = true
	$Control.show()

func unpause_game():
	print("unpausing")
	unpause.emit()
	get_tree().paused = false
	$Control.hide()
	child_control.hide()
