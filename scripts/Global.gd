extends Node

#@export var canMove = true;
@export var doorOpen = false;
@export var drinkRootBeer = false;

#@export var snackChoice = "none"
#@export var drinkChoice = "none"
@export var hasFood = false
@export var hasDrink = false
var has_key = false

signal got_key

var doorTriggers = "res://doorTriggers.gd"
signal opening_door
signal drink_rootbeer
signal go_inside

func _ready() -> void:
	#DialogueManager.connect.drink_rootbeer("_on_drinking_rootbeer")
	#DialogueManager.opening_door.connect("_open_EMP_door")
	#DialogueManager.connect("opening_door", Callable(self,"_open_EMP_door"))
	#Global.opening_door.connect(_door_signal)
	#Global.drink_rootbeer.connect(_on_drinking_rootbeer)
	pass

#func _set_can_move(x: bool):
	#canMove = x

func _on_drinking_rootbeer(b):
	drinkRootBeer = b;

func _door_signal():
	print("testingdwdd")
	Global.emit_signal("opening_door")
