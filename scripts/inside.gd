extends SubViewportContainer

@onready var player = $SubViewport/Player
@onready var emp_door = $SubViewport/Pivot/gasStation_EMP/empDoor
@onready var block = $"SubViewport/Pivot/triggerBoxes/EMP door/StaticBody3D"
@onready var drink_can = $SubViewport/Pivot/gasStation_EMP/drinkCan

func _ready():
	if not SaveSystem.pending_save_data.is_empty():
		var save_data = SaveSystem.pending_save_data
		
		if save_data.has("player_pos"):
			player.position = save_data["player_pos"]
		
		if save_data.has("door_opened"):
			SaveSystem.door_opened = save_data["door_opened"]
			Global.door_open = true
		
		SaveSystem.pending_save_data.clear()
	if Global.door_open:
		block.rotation.y = deg_to_rad(90)
		emp_door.rotation.y = deg_to_rad(-90)
		
	if ItemDatabase.item_list['rb'].in_inv:
		drink_can.hide()
