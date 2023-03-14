extends Node2D

signal restart

func _input(_event):
	if Input.is_action_just_pressed("restart"):
		emit_signal("restart")
