extends Node2D

func _ready():
	$Player.input_disabled = true
	var text_box = load("res://Scenes/TextBox.tscn").instance()
	add_child(text_box)
	text_box.global_position = $Player.global_position + Vector2(24, -48)
	text_box.initialize(["...", "... am I dreaming? ...", "I did just fall asleep...", "How do I wake up? ...", "Wait, I remember now...", "Falling from high places will wake me up!"])
	text_box.connect("tree_exiting", self, "_on_TextBox_tree_exiting")

func _on_TextBox_tree_exiting():
	$Player.input_disabled = false
