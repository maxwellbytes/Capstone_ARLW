extends Node3D

@onready var block = $"EMP door/StaticBody3D"
#@onready var block2 = $StaticBody3D/Actionable/CollisionShape3D2
@onready var EMP_door = $"../gasStation_EMP/empDoor"
@onready var player = $"../Node3D/Player/Pivot/sodaZachary/AnimationPlayer"
@onready var drink_can = $"../gasStation_EMP/drinkCan"


func _ready():
	Global.opening_door.connect(_open_EMP_door)
	Global.drink_rootbeer.connect(_drinking_rootbeer)

func _drinking_rootbeer():
	State.key_status = "has"
	print("playing anim")
	Global.drinkRootBeer = true
	player.play("anims/drinkRootBeer")
	drink_can.visible = false
	await player.animation_finished
	print("anim finished")
	Global.drinkRootBeer = false

func _open_EMP_door():
	print("testing")
	#block.disabled = true
	#block2.disabled = true
	
	#block.set_collision_layer_value(2, true)s
	#block.set_collision_layer_value(1, false)
	block.rotation.y = deg_to_rad(90)
	EMP_door.rotation.y = deg_to_rad(-90)
