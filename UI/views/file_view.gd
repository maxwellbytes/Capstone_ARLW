extends Control


@onready var inv = $inv_sheet
@onready var parent = $"../.."

@onready var empty = Rect2(0, 0, 188, 110)
@onready var keysFocus = Rect2(188, 0, 188, 110)
@onready var keysExit = Rect2(376, 0, 188, 110)
@onready var rbKeys = Rect2(0, 110, 188, 110)
var backFocused = true
var curr_slot = 0
var curr_item = ''
#var curr_item: Item

#connected to change_view() method in pause_menu.gd
signal exit(icon_name: String)

# maybe change state & region names to match name in inventory dict
@onready var regions = {
	"empty": Rect2(0, 0, 188, 110),
	"keys_start": Rect2(190, 0, 188, 110),
	"keys_exit": Rect2(380, 0, 188, 110),
	"rb_start": Rect2(0, 110, 188, 110),
	"rb_focus": Rect2(190, 110, 188, 110),
	"rb_exit": Rect2(380, 110, 188, 110)
}

enum Inventory_State { EMPTY, KEY_START, KEY_EXIT, RB_START, RB_FOCUS, RB_EXit }
var mapped_regions = {
	Inventory_State.EMPTY: "empty",
	Inventory_State.KEY_START: "keys_start",
	Inventory_State.KEY_EXIT: "keys_exit",
	Inventory_State.RB_START: "rb_start",
	Inventory_State.RB_FOCUS: "rb_focus",
	Inventory_State.RB_EXit: "rb_exit"
}

# Called when the node enters the scene tree for thde first time.
func _ready() -> void:
	inv.texture.region = regions["empty"]
	parent.now_visible.connect(open)
	#parent.now_visible.connect(made_visible)

func open():
	var has_key = ItemDatabase.item_list['key'].in_inv
	var has_rb = ItemDatabase.item_list['rb'].in_inv
	#var inv_state = calculate_inventory_state(has_key, has_rb)
	#inv.texture_region = regions[inv_state]
	
	if has_key and has_rb:
		curr_item = 'rb'
		curr_slot = 0
	elif has_key:
		curr_item = 'keys'
		curr_slot = 0
	else:
		inv.texture.region = regions['empty']
		#back button highlighted
		curr_slot = 2
	update_display()
	#if ItemDatabase.item_list['key'].in_inv:
		#if ItemDatabase.item_list['rb'].in_inv:
			#inv.texture.region = regions['rbKeys']
		#else:
			#inv.texture.region = regions['keysFocus']
	#else:
		#inv.texture.region = regions["empty"] #might not need this?
		#currSlot = 4

# make this logic cleaner
# remove key from inventory at some point?
func calculate_inventory_state(has_key: bool, has_rb: bool):
	if not has_key and not has_rb:
		return 'empty'
	elif has_key and not has_rb:
		return 'keys_start'
	#elif not has_key and has_rb:
		#return 2
	elif has_key and has_rb:
		return 'rb_start'
	else:
		return 'empty'

func update_display():
	if curr_item == '':
		inv.texture.region = regions['empty']
		return
	var state_suffix = get_suffix()
	var region_name = curr_item + '_' + state_suffix
	var has_key = ItemDatabase.item_list['key'].in_inv
	var has_rb = ItemDatabase.item_list['rb'].in_inv
	if has_key and has_rb:
		region_name = 'rb' + '_' + state_suffix
		if region_name in regions:
			inv.texture.region = regions[region_name]		
	elif has_key:
		if region_name in regions:
			inv.texture.region = regions[region_name]
	else:
		pass

# TODO (maybe): fix this to be more adaptable to changes made to the items
func get_suffix() -> String:
	if curr_slot == 2:
		return 'exit'
	elif curr_slot == 0:
		return 'start'
	else:
		return 'focus'

func _input(event: InputEvent) -> void:
	if GameManager.curr_view != 'FILES':
		return
	if Input.is_action_just_pressed('ui_accept'):
		if curr_slot == 2:
			exit.emit('HOME')
			get_viewport().set_input_as_handled()
			#print("exit clicked")
			#GameManager.open_view('HOME')
			#add item selection logic here if i implement it
	if Input.is_action_just_pressed('move_forward'):
		#if curr_slot == 3:
			#curr_slot = 0
			#update_display()
		cycle_item(-1)
		get_viewport().set_input_as_handled()
	if Input.is_action_just_pressed('move_back'):
		cycle_item(1)
		get_viewport().set_input_as_handled()


func cycle_item(direction: int):
	# ideas on how to make this more adjustable:
	#	- have some function that returns all items currently in inventory, doesn't have to be in this script. could then get # of items too
	var has_key = ItemDatabase.item_list['key'].in_inv
	var has_rb = ItemDatabase.item_list['rb'].in_inv
	
	if direction > 0:
		# available slots = 3
		if has_key and has_rb:
			if curr_slot == 2:
				#maybe change this repeat logic to be at the top?? idk im gonna make sure it works first
				curr_slot = 0
				curr_item = 'keys'
			else:
				curr_slot = curr_slot + 1
				if curr_slot == 1:
					curr_item = 'rb'
				#elif curr_slot == 2:
					#curr_item = 'exit'
		# available slops = 2
		elif has_key:
			if curr_slot == 2:
				curr_slot = 0
				curr_item = 'keys'
			# dont have key so only two slots possible
			else:
				curr_slot = 2
				#curr_item = 'exit'
		# available slots = 1
		# could just be an else since you can't have the rootbeer without the key, but better safe than sorry ig
		elif not has_key and not has_rb:
			pass
	
	if direction < 0:
		if has_key and has_rb:
			if curr_slot == 0:
				curr_slot = 2
				#curr_item = 'exit'
			else:
				curr_slot = curr_slot - 1
				if curr_slot == 0:
					curr_item = 'keys'
				elif curr_slot == 1:
					curr_item = 'rb'
		# available slops = 2
		elif has_key:
			if curr_slot == 0:
				curr_slot = 2
				#curr_item = 'exit'
			else:
				curr_slot = 0
				curr_item = 'keys'
		# available slots = 1
		# could just be an else since you can't have the rootbeer without the key, but better safe than sorry ig
		elif not has_key and not has_rb:
			pass
	update_display()
#func _physics_process(delta: float) -> void:
	#if ItemDatabase.item_list['key'].in_inv:
		#inv.texture.region = regions["keysFocus"]
		#backFocused = false

#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed('ui_accept') and GameManager.curr_view == "FILES":
		#if curr_slot == 4:
			#GameManager.open_view("HOME")
	#if Input.is_action_just_pressed('move_back'):
		#
		#match curr_slot:
			#0:
				#inv.texture.region = regions['keysExit']
			#1:
				#inv.texture.region = regions['']
		#if curr_slot == 4:
			#curr_slot = 0
			#inv.texture.region = regions['keysExit']
			#backFocused = true
	#if Input.is_action_just_pressed('move_forward'):
		#if curr_slot != 0:
			#inv.texture.region = regions['keysFocus']
			#backFocused = false

#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("ui_accept") and GameManager.curr_view == "HOME":
		#icon_selected.emit(curr_icon.name)
	#if Input.is_action_just_pressed("move_right"):
		#next_icon("RIGHT")
	#if Input.is_action_just_pressed("move_left"):
		#next_icon("LEFT")
	#if Input.is_action_just_pressed("move_forward"):
		#next_icon("UP")
	#if Input.is_action_just_pressed("move_back"):
		#next_icon("DOWN")

func made_visible():
	$".".show()
	$VBoxContainer.show()
	var children = $VBoxContainer.get_children()
	print("main visibility: " + str($".".visible))
	print("bg visibility: " + str($TextureRect.visible))
	print("VBox visibility: " + str($VBoxContainer.visible))
	print("slot size " + str($VBoxContainer/slot1.size))
	for child in children:
		print("making visible")
		child.show()
