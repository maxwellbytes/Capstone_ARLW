extends Area3D

@onready var blocker = $"../StaticBody3D/CollisionShape3D"
@onready var interact_area = $"."
#var resource = load("res://dialogue/main.dialogue")

var player_by_door = false
var is_open = false
var opens_door = false;

func _process(delta: float) -> void:
	if State.door_status == "open":
		#print("testing")
		blocker.disabled = true


func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		player_by_door = true


func _on_body_exited(body: Node3D) -> void:
	if body.name == "Player":
		player_by_door = false

#func _input(event):
	#if player_by_door && event.is_action_pressed("interact"):
		##DialogueManager.show_dialogue_balloon(resource, "start")
		##var dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
		##if Input.is_action_pressed("ui_accept"):
			##dialogue_line = await DialogueManager.get_next_dialogue_line(resource)
		#toggle_door()

func toggle_door():
	#print("test")
	is_open = !is_open
	blocker.disabled = is_open
