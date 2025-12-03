extends SubViewportContainer

@onready var player = $SubViewport/playerCamera/Player
@onready var keys = $SubViewport/Pivot/keyRing2/keyRing

func _ready():
	# Apply saved position if loading from save
	if not SaveSystem.pending_save_data.is_empty():
		var save_data = SaveSystem.pending_save_data
		
		# Apply player position
		if save_data.has("player_position"):
			player.position = save_data["player_position"]
			print("Player position restored to: ", player.position)
		
		# Apply door state
		if save_data.has("door_opened"):
			SaveSystem.door_opened = save_data["door_opened"]
			# If you have a door node, update it here:
			# if has_node("Door"):
			#     $Door.opened = SaveSystem.door_opened
		
		# Clear pending data after applying
		SaveSystem.pending_save_data.clear()
		print("Save data applied!")
	Global.got_key.connect(pick_up_key)

func pick_up_key():
	keys.hide()
