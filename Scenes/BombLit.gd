extends RigidBody2D

func destroy():
	get_tree().queue_delete(self)

func explode():
	set_gravity_scale(0.0)
	set_linear_damp(1000000)
	set_collision_layer_bit(1, false)
	set_collision_mask_bit(1, false)
	$Sprite.visible = false
	$AnimatedSprite.visible = true
	$AnimatedSprite.play("explosion")

func _on_Timer_timeout():
	explode()

func _on_AnimatedSprite_animation_finished():
	destroy()

func _on_BombLit_body_entered(body):
	if body.is_in_group("Block"):
		body.destroy()
		explode()
