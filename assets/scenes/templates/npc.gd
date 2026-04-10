extends "res://character.gd"
@export var dialogue_start = "start"
var player

func _ready() -> void:
	if can_move:
		$RandomMoveTimer.start(randf_range(0.5,3.0))

func on_interact():
	print_debug("Talked to character: " + dialogue_start)
	player = GameManager.player
	var dir=player.global_position-global_position
	can_move=false
	velocity = Vector2.ZERO
	moving=false
	animate(dir.normalized(),false,true)
	await get_tree().create_timer(0.5)
	can_move=true


func _on_random_move_timer_timeout() -> void:
	var rand_dir = Vector2(randi_range(-1,1),randi_range(-1,1))
	move_char(rand_dir,randf_range(0.1,0.6),0.5)
	await move_completed
	$RandomMoveTimer.start(randf_range(0.5,3.0))
