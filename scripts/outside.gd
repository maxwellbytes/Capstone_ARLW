extends SubViewportContainer

@onready var player = $SubViewport/playerCamera/Player
@onready var keys = $SubViewport/Pivot/keyRing2/keyRing

func _ready():
	if not SaveSystem.pending_save_data.is_empty():
		var save_data = SaveSystem.pending_save_data
		
		if save_data.has("player_pos"):
			player.position = save_data["player_pos"]
		
		if save_data.has("door_opened"):
			SaveSystem.door_opened = save_data["door_opened"]
		
		SaveSystem.pending_save_data.clear()
	Global.got_key.connect(pick_up_key)
	
	if ItemDatabase.item_list['key'].in_inv:
		keys.hide()

func pick_up_key():
	keys.hide()
