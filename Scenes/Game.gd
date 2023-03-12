extends Node

var level = 0

func _ready():
	# TODO: instead of loading level 1, load the initial (cut)scene
	level += 1
	load_level("res://Scenes/Level1.tscn")

func load_level(path):
	print("loading level " + path)
	
	var old_levels = get_tree().get_nodes_in_group("Level")
	for old_level in old_levels:
		old_level.queue_free()

	var new_level = load(path).instance()
	add_child(new_level)
	new_level.get_node("Player").connect("wake_up", self, "_on_Player_wake_up")

func _on_Player_wake_up():
	if level == 1:
		level += 1
		load_level("res://Scenes/Level2.tscn")
	if level == 2:
		print("go to final scene?")
