extends Control

@onready var container = $VBoxContainer.get_children()
@onready var vbox = $VBoxContainer
@onready var emitter = $".."
@onready var control = $"."

# atlas regions for empty slots
@onready var emptyTop: Rect2 = Rect2(69, 143, 69, 13)
@onready var empty: Rect2 = Rect2(69, 149, 69, 13)
@onready var emptyBottom: Rect2 = Rect2(69, 154, 69, 13)
@onready var emptyBoth: Rect2 = Rect2(0, 143, 69, 13)
@onready var backButton: Rect2 = Rect2(0, 130, 69, 13)

@onready var onBack = false
@onready var inv_open = false

signal close_menu
signal close_inv

#TODO:
# add in-script controller
# add close_menu.emit(false) when "back" button is clicked

func _ready():
	#vbox.hide()
	emitter.display_inv.connect(display_files)

#func _input(event):
	## TODO: check and make sure player is not actively interacting with something
	#if Input.is_action_just_pressed("pause"):
		#if get_tree().paused:
			#_unpause_game()
		#else:
			#_pause_game()
	#
	#if get_tree().paused and visible and curr_screen == "main":
		#_nav_pause_menu(event)
	#
	#if visible and Input.is_action_just_pressed("interact") and curr_screen == "main":
		##tell the menu that an app has been clicked
		#display.emit()

func _input(event):
	if Input.is_action_just_pressed("pause") and inv_open == true:
		if get_tree().paused:
			pass
			#close_menu.emit()
	#change to check if back button is selected
	if Input.is_action_just_pressed("interact"):
		#if back button is pressed emit close_inv
		pass

func display_files():
	#print("displaying files")
	# figure out how to start getting user input from here to handle selection?
	# might have to handle major logic in main script (select, inspect, etc)
	# but could make a signal for loading the menu (have that) and changing sprites
	
	control.show()
	inv_open = true
	# has a non-filled section been started?
	var started = false
	
	for i in range(container.size() - 2):
		var slot = container[i]
		var item = Inventory.items[i] if i < Inventory.items.size() else null
		
		if item:
			print(item.name)
			slot.texture.region = item.altas_region
		# non-filled section not started
		#elif started == false:
			## only 1 empty slot
			#if i == container.size():
				#pass
			## only 2 empty slots
			#elif  i + 1 == container.size():
				#slot.texture.region = emptyTop
			#else:
				#
				#pass
			#pass
		else:
			var leftover = container.size() - i
			if leftover == 0:
				slot.texture.region = emptyBoth
			elif leftover == 2:
				slot.texture.region = emptyTop
				slot = container[i + 1]
				slot.texture.region = emptyBottom
				return
			else:
				slot.texture.region = emptyTop
				for k in range (leftover - 2):
					slot = container[i + k + 1]
					slot.texture.region = emptyBoth
				slot = container[container.size() - 1]
				slot.texture.region = emptyBottom
	container[5].texture.region = backButton
