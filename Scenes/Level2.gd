extends Node2D

signal auto_win

func _ready():
	$Player.input_disabled = true
	var text_box = load("res://Scenes/TextBox.tscn").instance()
	add_child(text_box)
	text_box.global_position = $Player.global_position + Vector2(24, -48)
	text_box.initialize(["Ugh, another dream?", "I guess I have to fall one more time...", "What are those? Apples?", "Maybe I should grab them..."])
	text_box.connect("tree_exiting", self, "_on_TextBox_tree_exiting")

func _on_TextBox_tree_exiting():
	$Player.input_disabled = false

func _on_Payphone_body_entered(body):
	if body.is_in_group("Player"):
		var text_box = load("res://Scenes/TextBox.tscn").instance()
		add_child(text_box)
		text_box.global_position = $Payphone.global_position + Vector2(-64, -64)
		if $WebsocketHandler.phone_number != null and $WebsocketHandler.code != null:
			text_box.initialize(["Call " + $WebsocketHandler.phone_number + "!", "The password is " + $WebsocketHandler.code + "!", "That's the only way out!"])
		else:
			text_box.initialize(["........."])

func _on_Payphone_body_exited(body):
	if body.is_in_group("Player"):
		# TODO: this is a hack TBH
		var text_boxes = get_tree().get_nodes_in_group("TextBox")
		for text_box in text_boxes:
			text_box.destroy()

func _on_WebsocketHandler_auto_win():
	emit_signal("auto_win")
