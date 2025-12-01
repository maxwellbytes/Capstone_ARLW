extends Camera3D
#og camera x,y,z -0.075, 4.164, 2.414 -45degree x, size=6, near=0.01

@export var player: Node3D
@export var follow_speed := 10.0
@export var bounds: Node3D

@export var min_x := -5.7 	#right, go negative to expand, -5
@export var max_x := 4	#left, go positive to expand, -1.4
@export var min_z := 4 	#up, go negative to expand, -2
@export var max_z := 11	#down, go positive to expand, 3.75

#var min_x: float
#var max_x: float
#var min_z: float
#var max_z: float

var initial_offset := Vector3.ZERO

func _ready():
	if player:
		#store the starting offset between camera and player
		initial_offset = global_transform.origin - player.global_transform.origin
	
	#old bounds method
		#var scale = bounds.scale * 0.5
		#var origin = bounds.global_transform.origin
		#min_x = origin.x - scale.x
		#max_x = origin.x + scale.x
		#min_z = origin.z - scale.z
		#max_z = origin.z + scale.z
		#print(min_x,max_x,min_z,max_z)

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
