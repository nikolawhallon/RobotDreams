extends Node

var level = 0

func _ready():
	var intro = load("res://Scenes/Intro.tscn").instance()
	add_child(intro)
	intro.connect("start_levels", self, "_on_Intro_start_levels")

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

func _on_Intro_start_levels():
	var cutscenes = get_tree().get_nodes_in_group("Cutscene")
	for cutscene in cutscenes:
		cutscene.queue_free()

	level += 1
	load_level("res://Scenes/Level1.tscn")
