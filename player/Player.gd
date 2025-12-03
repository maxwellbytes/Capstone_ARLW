extends CharacterBody3D

#player speed m/s
@export var speed = 2.5
#downward acceleration when in the air ms^2
@export var fall_acceleration = 75
#@export_range(0.0,1.0) var mouse_sensitivity = 0.01
#@export var tilt_limit = deg_to_rad(75)

@onready var actionableFinder: Area3D = $Pivot/Direction/ActionableFinder
@onready var player = $"."

#@onready var _camera := $cameraPivot/SpringArm3D/Camera3D as Camera3D
#@onready var _camera_pivot := $cameraPivot as Node3D

var target_velocity = Vector3.ZERO
var cutsene_playing = false;

#set the current state as idle since no button is being pressed
#var curr_state = "idleAnim"

enum States {IDLE, WALK, INTERACT}
@export var curr_state: States = States.IDLE

#creates socket for the soda can to attach to hand
@onready var hand_socket = $Pivot/sodaZachary/rig/Skeleton3D/BoneAttachment3D

func give_item(item_scene: PackedScene):
	var item = item_scene.instantiate()
	hand_socket.add_child(item)

func remove_item():
	for c in hand_socket.get_children():
		c.queue_free()

#test camera code
#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion:
		#_camera_pivot.rotation.x -= event.relative.y * mouse_sensitivity
		# Prevent the camera from rotating too far up or down.
		#_camera_pivot.rotation.x = clampf(_camera_pivot.rotation.x, -tilt_limit, tilt_limit)
		#_camera_pivot.rotation.y += -event.relative.x * mouse_sensitivity

func _ready():
	#$Pivot/tempCharacterOOPS2/AnimationPlayer.play("idleAction")
	#$Pivot/tempCharacterOOPS2/AnimationPlayer.speed_scale = 1.5
	#$Pivot/tempCharacterEditedbackup2/AnimationPlayer.play("idleAnim")
	$Pivot/sodaZachary/AnimationPlayer.play("idleAnim")
	if Engine.has_singleton("DialogueManager"):
		var dialogue_manager = Engine.get_singleton("DialogueManager")
		if dialogue_manager.has_signal("dialogue_ended"):
			dialogue_manager.dialogue_ended.connect(end_interact)
	#SaveSystem.get_player.connect(send_save_data)
	SaveSystem.player = self

func send_data() -> StringName:
	return get_tree().current_scene.name

#func send_save_data() -> Dictionary:
	#return {
		#"position_x": player.position.x,
		#"position_y": player.position.y,
		#"position_z": player.position.z
	#}

func end_interact(resource: DialogueResource):
	if curr_state == States.INTERACT:
		set_state(States.IDLE)

#func check_state(new_state: String) -> void:
	#if new_state != curr_state:
		#$Pivot/sodaZachary/AnimationPlayer.play(new_state)
		#curr_state = new_state

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		#DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "start")
		
		#ideally only actionables will overlap since they are on a specific physics layer
		var actionables = actionableFinder.get_overlapping_areas()
		if actionables.size() > 0:
			set_state(States.INTERACT)
			actionables[0].action()
			
			return

func set_state(new_state:int) -> void:
	var prev_state := curr_state
	curr_state = new_state
	if curr_state == States.IDLE || curr_state == States.INTERACT:
		$Pivot/sodaZachary/AnimationPlayer.play("idleAnim")
	elif curr_state == States.WALK:
		$Pivot/sodaZachary/AnimationPlayer.play("walk4")

#maybe switch movement to _unhandled_input??
func _physics_process(delta):
		var direction = Vector3.ZERO
		
		if curr_state == States.IDLE || curr_state == States.WALK:
			if Input.is_action_pressed("move_right"):
				set_state(States.WALK)
				direction.x += .75
			if Input.is_action_pressed("move_left"):
				set_state(States.WALK)
				direction.x -= .75
			if Input.is_action_pressed("move_back"):
				set_state(States.WALK)
				direction.z += .75
			if Input.is_action_pressed("move_forward"):
				set_state(States.WALK)
				direction.z -= .75
		
		if curr_state != States.INTERACT && Input.is_action_just_released("movement"):
			set_state(States.IDLE)
		
		#code from godot docs:
		if direction != Vector3.ZERO:
			direction = direction.normalized()
			#Setting the basis property will affect the rotation of the node.
			$Pivot.basis = Basis.looking_at(direction)

		#ground velocity
		target_velocity.x = direction.x * speed
		target_velocity.z = direction.z * speed

		# Vertical Velocity
		if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
			target_velocity.y = target_velocity.y - (fall_acceleration * delta)

		# Moving the Character
		velocity = target_velocity
		move_and_slide()
	
	
	#if not Global.canMove:
		#$Pivot/sodaZachary/AnimationPlayer.play("idleAnim")
#
	#
##TODO: clean all of this up
	#if Global.canMove:
		#if Input.is_action_pressed("move_right"):
#
			#direction.x += .75
		#if Input.is_action_pressed("move_left"):
			#direction.x -= .75
		#if Input.is_action_pressed("move_back"):
			#direction.z += .75
		#if Input.is_action_pressed("move_forward"):
			#direction.z -= .75
	
	#if Input.is_action_just_released("move_right"):
	#if Input.is_action_just_released("move_left"):
	##if Input.is_action_just_released("move_back"):
		#check_state("idleAnim")
	#if Input.is_action_just_released("move_forward"):
		#check_state("idleAnim")
