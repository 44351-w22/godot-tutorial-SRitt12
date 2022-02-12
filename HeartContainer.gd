extends HBoxContainer

var heart_full = preload("heart_full.png")
var heart_empty = preload("heart_empty.png")

func update_health(health):
	for i in get_child_count():
		if health > i:
			get_child(i).texture = heart_full
		else:
			get_child(i).texture = heart_empty
