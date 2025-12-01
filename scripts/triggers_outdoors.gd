extends Node3D

@onready var cutscene_player = $"../../../AnimatedSprite2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cutscene_player.visible = false
	Global.go_inside.connect(_go_inside)

func _go_inside():
	cutscene_player.visible = true
	for i in range(3):
		cutscene_player.play("cutscene")
		await cutscene_player.animation_finished
		i = i + 1
	
	get_tree().change_scene_to_file("res://test.tscn")
