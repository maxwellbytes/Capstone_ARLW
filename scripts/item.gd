#inventory item templete
extends Resource
class_name Item

var name: String
var in_inv: bool
var atlas_region: Rect2
var select_region: Rect2
#TODO: add variable for sprite to display. and maybe description
# use sprite atlas for item display, only load animated version if player hits "interact" ?
