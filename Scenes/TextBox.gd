extends Node2D

var texts = []
var text_index = 0

func destroy():
	get_tree().queue_delete(self)
	
func _input(_event):
	if Input.is_action_just_pressed("next"):
		if $Label.percent_visible == 1.0:
			next_text()
			$EnterLabel.visible = false
		else:
			$Label.percent_visible = 1.0

func next_text():
	text_index += 1
	if text_index == len(texts):
		destroy()
		return
	$Label.text = texts[text_index]
	$Label.percent_visible = 0.0
	$ScrollTimer.start()

func _ready():
	$Label.percent_visible = 0.0

func initialize(input_texts):
	if len(input_texts) == 0:
		destroy()
	texts = input_texts
	$Label.text = texts[text_index]
	$ScrollTimer.start()

func _on_ScrollTimer_timeout():
	$Label.percent_visible = clamp($Label.percent_visible + 0.05, 0.0, 1.0)
	
	if $Label.percent_visible == 1.0:
		$ScrollTimer.stop()

func _on_EnterBlinkTimer_timeout():
	if $Label.percent_visible == 1.0:
		if $EnterLabel.visible == true:
			$EnterLabel.visible = false
		elif $EnterLabel.visible == false:
			$EnterLabel.visible = true
