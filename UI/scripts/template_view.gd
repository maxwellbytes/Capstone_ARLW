extends Resource
class_name View

#enum view_names {FILES, CAMERA, GALLERY, SAVE, SETTINGS, GPS}

var name: String
var row: String
var atlas_region: Rect2
var select_region: Rect2

# can't tell if this is easier than calculating it with the index??
# 10/20 used to have these as a Rect2 type but switched to strings
#     can get the correct Rect2 from the object itself, just need this field to select the right object
var right: String
var left: String
var up: String
var down: String
