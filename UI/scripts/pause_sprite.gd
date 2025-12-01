extends Control

@onready var bg_sprite = $TextureRect
@onready var child_control = $Control

# slots on slots on slots babey
@onready var slots = [
	$Control/VBoxContainer/slot1,
	$Control/VBoxContainer/slot2,
	$Control/VBoxContainer/slot3,
	$Control/VBoxContainer/slot4,
	$Control/VBoxContainer/slot5,
	$Control/VBoxContainer/slot6
]

@onready var regions = {
	"files": Rect2(0, 0, 320, 180),
	"camera": Rect2(320, 0, 320, 180),
	"gallery": Rect2(640, 0, 320, 180),
	"save": Rect2(0, 180, 320, 180),
	"settings": Rect2(320, 180, 320, 180),
	"gps": Rect2(640, 180, 320, 180)
}

#var curr_region: String = "files"
#var on_main = true
signal display_inv
signal inv_open

#func _is_on_main(flag: bool):
	#on_main = flag

func _ready():
	#process_mode = Node.PROCESS_MODE_ALWAYS
	process_mode = Node.PROCESS_MODE_DISABLED
	child_control.hide()
	hide()

	GameManager.paused_changed.connect(on_paused_changed)
	GameManager.view_changed.connect(on_view_changed)

func on_paused_changed(is_paused: bool):
	if is_paused:
		show()
	else:
		hide()
		child_control.hide()

func on_view_changed(menu: String):
	match menu:
		"pause":
			bg_sprite.texture.region = regions["files"]
			child_control.hide()
		"inventory":
			bg_sprite.texture.region = regions["file_page"]
			child_control.show()
		"none":
			hide()
