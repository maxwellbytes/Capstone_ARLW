extends Node
# database of all possible inventory items

const item = preload("res://scripts/item.gd")
var item_list: Dictionary = {}

func _ready() -> void:
	var key = item.new()
	key.name = "key"
	key.in_inv = false
	key.atlas_region = Rect2(0, 0, 69, 13)
	key.select_region = Rect2(69, 0, 69, 13)
	item_list["key"] = key
	
	var rb = item.new()
	rb.name = "rootbeer"
	key.in_inv = false
	rb.atlas_region = Rect2(0, 13, 69, 13)
	rb.select_region = Rect2(69, 13, 69, 13)
	item_list["rb"] = rb
	
	var water = item.new()
	water.name = "water"
	key.in_inv = false
	water.atlas_region = Rect2(0, 39, 69, 13)
	water.select_region = Rect2(69, 39, 69, 13)
	item_list["water"] = water
	
	var juice = item.new()
	juice.name = "juice"
	key.in_inv = false
	juice.atlas_region = Rect2(0, 52, 69, 13)
	juice.select_region = Rect2(69, 52, 69, 13)
	item_list["juice"] = juice
	
	var soda = item.new()
	soda.name = "soda"
	key.in_inv = false
	soda.atlas_region = Rect2(0, 65, 69, 13)
	soda.select_region = Rect2(69, 65, 69, 13)
	item_list["soda"] = soda
	
	var eng_drink = item.new()
	eng_drink.name = "engDrink"
	key.in_inv = false
	eng_drink.atlas_region = Rect2(0, 130, 69, 13)
	eng_drink.select_region = Rect2(69, 130, 69, 13)
	item_list["engDrink"] = eng_drink
	
	var chips = item.new()
	chips.name = "chips"
	key.in_inv = false
	chips.atlas_region = Rect2(0, 78, 69, 13)
	chips.select_region = Rect2(69, 78, 69, 13)
	item_list["chips"] = chips
	
	var candy = item.new()
	candy.name = "candy"
	key.in_inv = false
	candy.atlas_region = Rect2(0, 91, 69, 13)
	candy.select_region = Rect2(69, 91, 69, 13)
	item_list["candy"] = candy
	
	var bfj = item.new()
	bfj.name = "bfj"
	key.in_inv = false
	bfj.atlas_region = Rect2(0, 104, 69, 13)
	bfj.select_region = Rect2(69, 104, 69, 13)
	item_list["bfj"] = bfj
	
	var crackers = item.new()
	crackers.name = "crackers"
	key.in_inv = false
	crackers.atlas_region = Rect2(0, 117, 69, 13)
	crackers.select_region = Rect2(69, 117, 69, 13)
	item_list["crackers"] = crackers
