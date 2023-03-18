extends Area2D

func _on_Hint_body_entered(body):
	if body.is_in_group("Player"):
		if !body.input_disabled:
			visible = true

func _on_Hint_body_exited(body):
	if body.is_in_group("Player"):
		if !body.input_disabled:
			visible = false
