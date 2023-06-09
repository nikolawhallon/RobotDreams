extends Node2D

signal auto_win

func _ready():
	$Player.input_disabled = true
	var text_box = load("res://Scenes/TextBox.tscn").instance()
	add_child(text_box)
	text_box.global_position = $Player.global_position + Vector2(24, -48)
	text_box.initialize(["Oof, how many times do I have to wake up..."])
	text_box.connect("tree_exiting", self, "_on_TextBox_tree_exiting")

func _on_TextBox_tree_exiting():
	$Player.input_disabled = false
