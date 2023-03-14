extends Node2D

signal start_levels

func _on_FadeoutTimer_timeout():
	modulate.a -= 0.02
	
	if modulate.a <= 0.0:
		emit_signal("start_levels")
