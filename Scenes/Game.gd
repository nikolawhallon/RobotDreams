extends Node

var level = 0
var infinite_bombs_collected = false

func _ready():
	load_intro()

func load_intro():
	clear_levels_and_cutscenes()

	var intro = load("res://Scenes/Intro.tscn").instance()
	add_child(intro)
	intro.connect("start_levels", self, "_on_Intro_start_levels")

func load_outro(ending_type):
	clear_levels_and_cutscenes()

	var outro = load("res://Scenes/Outro.tscn").instance()
	add_child(outro)
	outro.connect("restart", self, "_on_Outro_restart")
	outro.initialize(ending_type)

	$CanvasLayer/MarginContainer/HBoxContainer.visible = false
	infinite_bombs_collected = false

func load_level(path):
	clear_levels_and_cutscenes()

	var new_level = load(path).instance()
	add_child(new_level)
	new_level.get_node("Player").connect("wake_up", self, "_on_Player_wake_up")
	new_level.get_node("Player").connect("infinite_bombs_collected", self, "_on_Player_infinite_bombs_collected")
	new_level.get_node("Player").infinite_bombs_collected = infinite_bombs_collected
	new_level.connect("auto_win", self, "_on_Level_auto_win")

func _on_Player_wake_up():
	if level == 1:
		level += 1
		load_level("res://Scenes/Level2.tscn")
	elif level == 2:
		level += 1
		load_level("res://Scenes/Level3.tscn")
	elif level == 3:
		load_outro(0)

func _on_Player_infinite_bombs_collected():
	$CanvasLayer/MarginContainer/HBoxContainer.visible = true
	infinite_bombs_collected = true

func _on_Intro_start_levels():
	level += 1
	load_level("res://Scenes/Level1.tscn")

func _on_Outro_restart():
	level = 0
	load_intro()

func clear_levels_and_cutscenes():
	var old_levels = get_tree().get_nodes_in_group("Level")
	for old_level in old_levels:
		old_level.queue_free()

	var cutscenes = get_tree().get_nodes_in_group("Cutscene")
	for cutscene in cutscenes:
		cutscene.queue_free()

func _on_Level_auto_win():
	load_outro(1)
