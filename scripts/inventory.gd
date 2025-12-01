extends Node

var items: Array = []

func add_item(item):
	items.append(item)

func remove_item(index):
	items.remove_at(index)
