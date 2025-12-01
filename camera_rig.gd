extends Camera3D

@export var player: Node3D
@export var min_bounds := Vector3(-50, 5, -50) # minimum x,y,z
@export var max_bounds := Vector3(50, 20, 50)  # maximum x,y,z
@export var follow_speed := 5.0

func _process(delta: float) -> void:
	if not player:
		return

	#target position is the player
	var target_pos = player.global_position

	#smoothly move camera towards player
	var new_pos = global_position.lerp(target_pos, follow_speed * delta)

	#clamp inside level bounds
	new_pos.x = clamp(new_pos.x, min_bounds.x, max_bounds.x)
	new_pos.y = clamp(new_pos.y, min_bounds.y, max_bounds.y)
	new_pos.z = clamp(new_pos.z, min_bounds.z, max_bounds.z)

	global_position = new_pos
	
