extends Area2D

func destroy():
	get_tree().queue_delete(self)

func _on_InfiniteBombs_body_entered(body):
	if body.is_in_group("Player"):
		body.infinite_bombs_collected = true
		body.emit_signal("infinite_bombs_collected")
		destroy()
