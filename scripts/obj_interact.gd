extends Area3D

var resource = load("res://dialogue/main.dialogue")
#toggle player ability to interact with items based on location
var player_in_area = false

func _process(delta: float) -> void:
	if player_in_area == true && Input.is_action_just_pressed('interact'):
		DialogueManager.show_dialogue_balloon(resource, "start")
		var dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
		if Input.is_action_pressed("ui_accept"):
			dialogue_line = await DialogueManager.get_next_dialogue_line(resource)

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player3D":
		player_in_area = true

func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player3D":
		player_in_area = false
