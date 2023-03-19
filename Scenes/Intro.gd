extends Node2D

signal start_levels

var velocity = Vector2(0, 10)
var k = 0.1

func _ready():
	var text_box = load("res://Scenes/TextBox.tscn").instance()
	add_child(text_box)
	text_box.global_position = $Bed.global_position + Vector2(16, -64)
	text_box.initialize(["I'm so tired.", "Time to sleep...", ".........", "...zzz..."])
	text_box.connect("tree_exiting", self, "_on_TextBox_tree_exiting")
	
func _process(delta):
	velocity += -k * $Bed.position
	$Bed.position += velocity * delta

func _on_FadeoutTimer_timeout():
	modulate.a -= 0.02
	
	if modulate.a <= 0.0:
		emit_signal("start_levels")

func _on_TextBox_tree_exiting():
	$Bed.animation = "sleeping"
	$FadeoutTimer.start()
