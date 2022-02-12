extends CanvasLayer

var heart_full = preload("heart_full.png")
var heart_empty = preload("heart_empty.png")

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")

	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_MessageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	
func update_health(health):
	for i in $HeartContainer.get_child_count():
		if health > i:
			$HeartContainer.get_child(i).texture = heart_full
		else:
			$HeartContainer.get_child(i).texture = heart_empty

