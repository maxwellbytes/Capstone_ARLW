extends Area3D

#attach the dialogue file
@export var dialogueResource: DialogueResource

#specifies which title we are starting from
@export var dialogueStart: String = "root_beer"


#shows the balloon when this actionable gets actioned
func action() -> void:
	DialogueManager.show_dialogue_balloon(dialogueResource, dialogueStart)
