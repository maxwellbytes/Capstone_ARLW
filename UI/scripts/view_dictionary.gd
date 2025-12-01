extends Node
# database of all possible inventory items

const view = preload("res://UI/scripts/template_view.gd")
static var view_dict: Dictionary = {}

static func load():
	if view_dict.size() > 0:
		return
	
	var files = view.new()
	files.name = "FILES"
	files.row = "TOP"
	files.atlas_region = Rect2(0, 0, 60, 54)
	files.select_region = Rect2(0, 108, 60, 54)
	files.right = "CAMERA"
	files.left = "GALLERY"
	files.up = "SAVE"
	files.down = "SAVE"
	view_dict["FILES"] = files
	
	var cam = view.new()
	cam.name = "CAMERA"
	cam.row = "TOP"
	cam.atlas_region = Rect2(60, 0, 60, 54)
	cam.select_region = Rect2(60, 108, 60, 54)
	cam.right = "GALLERY"
	cam.left = "FILES"
	cam.up = "SETTINGS"
	cam.down = "SETTINGS"
	view_dict["CAMERA"] = cam
	
	var gallery = view.new()
	gallery.name = "GALLERY"
	gallery.row = "TOP"
	gallery.atlas_region = Rect2(120, 0, 60, 54)
	gallery.select_region = Rect2(120, 108, 60, 54)
	gallery.right = "FILES"
	gallery.left = "CAMERA"
	gallery.up = "GPS"
	gallery.down = "GPS"
	view_dict["GALLERY"] = gallery
	
	var save = view.new()
	save.name = "SAVE"
	save.row = "BOTTOM"
	save.atlas_region = Rect2(0, 54, 60, 54)
	save.select_region = Rect2(0, 162, 60, 54)
	save.right = "SETTINGS"
	save.left = "GPS"
	save.up = "FILES"
	save.down = "FILES"
	view_dict["SAVE"] = save
	
	var settings = view.new()
	settings.name = "SETTINGS"
	settings.row = "BOTTOM"
	settings.atlas_region = Rect2(60, 54, 60, 54)
	settings.select_region = Rect2(60, 162, 60, 54)
	settings.right = "GPS"
	settings.left = "SAVE"
	settings.up = "CAMERA"
	settings.down = "CAMERA"
	view_dict["SETTINGS"] = settings
	
	var gps = view.new()
	gps.name = "GPS"
	gps.row = "BOTTOM"
	gps.atlas_region = Rect2(120, 54, 60, 54)
	gps.select_region = Rect2(120, 162, 60, 54)
	gps.right = "SAVE"
	gps.left = "SETTINGS"
	gps.up = "GALLERY"
	gps.down = "GALLERY"
	view_dict["GPS"] = gps

#check what neighbor to pull up by matching the name field
#maybe pass the input direction in to the method

func _ready() -> void:
	pass

#func _ready() -> void:
	#var key = item.new()
	#key.name = "key"
	#key.atlas_region = Rect2(0, 0, 69, 13)
	#key.select_region = Rect2(69, 0, 69, 13)
	#item_list["key"] = key
