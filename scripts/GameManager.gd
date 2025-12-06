extends Node

var is_paused: bool = false
@export var curr_view: String = "CLOSED"
var in_app = false


#signal paused_toggled(is_paused: bool)
signal menu_toggled(is_paused: bool)
signal view_changed(new_view: String)

func getPauseState():
	return is_paused

# pause stuff
func toggle_pause():
	
	is_paused = !is_paused
	# makes sure it opens the home view every time the game is paused
	curr_view = "HOME" if is_paused else ""
	menu_toggled.emit(is_paused)
	view_changed.emit(curr_view)
	get_tree().paused = is_paused
	print(is_paused)
	if !is_paused:
		close_view()
	#curr_screen = if is_paused "pause_menu" else "home"

func open_view(view_name: String):
	#print("opening view")
	if !is_paused:
		#view_name = "HOME"
		toggle_pause()
	curr_view = view_name
	view_changed.emit(view_name)

func close_view():
	curr_view = ""
	is_paused = false
	get_tree().paused = false
	menu_toggled.emit(false)
	view_changed.emit("")
	
#func set_paused(value: bool):
	#is_paused = value
	#get_tree().paused = value
	#paused_changed.emit(is_paused)

# menu stuff
#func set_view(value: String):
	#curr_view = value
	#view_changed.emit(curr_view)
