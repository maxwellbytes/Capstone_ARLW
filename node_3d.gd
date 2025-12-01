extends Node3D

@export var player: Node3D
@export var min_bounds := Vector3(-50, 5, -50)
@export var max_bounds := Vector3(50, 20, 50)
@export var deadzone_size := Vector2(2.0, 2.0) # width/height of dead-zone in world units
@export var follow_speed := 5.0

func _process(delta: float) -> void:
	if not player:
		return

	var pos = global_position
	var player_pos = player.global_position

	# Dead-zone check (top-down, so we care about X and Z)
	var dx = player_pos.x - pos.x
	var dz = player_pos.z - pos.z

	var half_w = deadzone_size.x * 0.5
	var half_h = deadzone_size.y * 0.5

	var target = pos

	if dx > half_w:
		target.x = player_pos.x - half_w
	elif dx < -half_w:
		target.x = player_pos.x + half_w

	if dz > half_h:
		target.z = player_pos.z - half_h
	elif dz < -half_h:
		target.z = player_pos.z + half_h

	# Smoothly interpolate toward the target
	var new_pos = pos.lerp(target, follow_speed * delta)

	# Clamp within level bounds
	new_pos.x = clamp(new_pos.x, min_bounds.x, max_bounds.x)
	new_pos.y = clamp(new_pos.y, min_bounds.y, max_bounds.y)
	new_pos.z = clamp(new_pos.z, min_bounds.z, max_bounds.z)

	global_position = new_pos
