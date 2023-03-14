extends RigidBody2D

func destroy():
	get_tree().queue_delete(self)
