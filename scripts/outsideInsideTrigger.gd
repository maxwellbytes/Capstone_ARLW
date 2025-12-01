extends Area3D

#if the player is in the door's area3d space
var player_by_door = false

func _input(event):
	if (player_by_door && event.is_action_pressed("interact")):
		print("input recieved")
		get_tree().change_scene_to_file("res://test.tscn")


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player_by_door = true

func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player_by_door = false
