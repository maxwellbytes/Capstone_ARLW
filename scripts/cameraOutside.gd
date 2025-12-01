extends Camera3D

@export var player: Node3D
@export var follow_speed := 10.0

@export var min_x := -50	#right, go negative to expand #might be opposite now
@export var max_x := 50	#left, go positive to expand
@export var min_z := -50 	#down, go negative to expand
@export var max_z := 50	#up, go positive to expand

var initial_offset := Vector3.ZERO

func _ready():
	if player:
		#store the starting offset between camera and player
		initial_offset = global_transform.origin - player.global_transform.origin

func _process(delta):
	if player == null:
		return
	
	#camera position i want
	var target_pos = player.global_transform.origin + initial_offset
	
	#clamp target position
	target_pos.x = clamp(target_pos.x, min_x, max_x)
	target_pos.z = clamp(target_pos.z, min_z, max_z)
	
	#follow player target, use lerp for smooth movement
	global_transform.origin = global_transform.origin.lerp(target_pos, follow_speed * delta)
