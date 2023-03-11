extends RigidBody2D

func destroy():
	get_tree().queue_delete(self)

func _on_BombLit_body_entered(body):
	if body.is_in_group("Block"):
		body.destroy()
		destroy()
