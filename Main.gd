extends Node

export (PackedScene) var Mob

var score
var highscore = 0


signal new_game
signal update_highscore(highscore)

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	# new_game()

func game_over():
	$ScoreTimer.stop()
	if score > highscore:
		highscore = score
	emit_signal("update_highscore", highscore)
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	
func new_game():
	score = 0
	$Player.health = 3
	emit_signal("new_game", $Player.health)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()
	

func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.offset = randi()
	var mob = Mob.instance()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation
	mob.position = $MobPath/MobSpawnLocation.position
	direction += PI / 2
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	var velocity = Vector2(rand_range(mob.min_speed, mob.max_speed),0)
	mob.linear_velocity = velocity.rotated(direction)

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

