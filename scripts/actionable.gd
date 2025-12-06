extends Area3D

#attach the dialogue file
@export var dialogueResource: DialogueResource

#specifies which title we are starting from
@export var dialogueStart: String = "start"

@export var textbox_type: String = "portrait"


#shows the balloon when this actionable gets actioned
func action() -> void:
	DialogueManager.show_balloon(dialogueResource, dialogueStart, textbox_type)
