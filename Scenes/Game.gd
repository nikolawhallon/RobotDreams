extends Node

var level = 1

func _ready():
	var new_level = load("res://Scenes/Level1.tscn").instance()
	add_child(new_level)
	
	$Player.global_position = Vector2(70, 230)
	
	$Player/Camera2D.limit_bottom = 260
	$Player/Camera2D.limit_left = 0
	$Player/Camera2D.limit_right = 476

func _on_Player_wake_up():
	var old_levels = get_tree().get_nodes_in_group("Level")
	for old_level in old_levels:
		old_level.queue_free()
	
	level += 1
	
	if level == 2:
		var new_level = load("res://Scenes/Level2.tscn").instance()
		add_child(new_level)

		$Player.global_position = Vector2(70, 230)
	
		$Player/Camera2D.limit_bottom = 260
		$Player/Camera2D.limit_left = 0
		$Player/Camera2D.limit_right = 504
