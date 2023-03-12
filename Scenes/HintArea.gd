extends Area2D

func _on_Hint_body_entered(body):
	if body.is_in_group("Player"):
		visible = true

func _on_Hint_body_exited(body):
	if body.is_in_group("Player"):
		visible = false
