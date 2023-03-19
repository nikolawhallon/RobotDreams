extends Node2D

signal restart

var ending_type
var ready_to_restart = false

var velocity = Vector2(0, 10)
var k = 0.1

func _process(delta):
	velocity += -k * $Bed.position
	$Bed.position += velocity * delta

func _input(_event):
	if Input.is_action_just_pressed("restart") and ready_to_restart:
		emit_signal("restart")

func initialize(_ending_type):
	ending_type = _ending_type
	if ending_type == 0:
		$Bed.animation = "robot_sleeping"
	else:
		$Bed.animation = "human_sleeping"
	
	modulate.a = 0.0

func _on_FirstTextBox_tree_exiting():
	if ending_type == 0:
		$Bed.animation = "robot_resting"
		var text_box = load("res://Scenes/TextBox.tscn").instance()
		add_child(text_box)
		text_box.global_position = $Bed.global_position + Vector2(16, -64)
		text_box.initialize(["I'm awake?", "Wait, I'm still a robot...", "I must still be dreaming!", "Is there something I missed?"])
		text_box.connect("tree_exiting", self, "_on_SecondTextBox_tree_exiting")
	else:
		$Bed.animation = "human_resting"
		var text_box = load("res://Scenes/TextBox.tscn").instance()
		add_child(text_box)
		text_box.global_position = $Bed.global_position + Vector2(16, -64)
		text_box.initialize(["I'm awake?", "It was fun being a robot.", "But infinite dreams are scary.", "I'm relieved to be awake!"])
		text_box.connect("tree_exiting", self, "_on_SecondTextBox_tree_exiting")

func _on_SecondTextBox_tree_exiting():
	if ending_type == 0:
		$RobotEndingLabel.visible = true
	else:
		$HumanEndingLabel.visible = true
	ready_to_restart = true

func _on_FadeinTimer_timeout():
	modulate.a += 0.02
	
	if modulate.a >= 1.0:
		var text_box = load("res://Scenes/TextBox.tscn").instance()
		add_child(text_box)
		text_box.global_position = $Bed.global_position + Vector2(16, -64)
		text_box.initialize([".........", "...zzz...", "..."])
		text_box.connect("tree_exiting", self, "_on_FirstTextBox_tree_exiting")
		$FadeinTimer.stop()

