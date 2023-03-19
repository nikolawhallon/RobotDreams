extends Area2D

var sfx_throw = preload("res://Assets/Sfx/throw.wav")

func destroy():
	get_tree().queue_delete(self)

func _ready():
	$AudioStreamPlayer2D.set_volume_db(-12.0)

func _on_InfiniteBombs_body_entered(body):
	if body.is_in_group("Player"):
		body.infinite_bombs_collected = true
		body.emit_signal("infinite_bombs_collected")
		visible = false
		set_collision_layer_bit(0, false)
		set_collision_mask_bit(0, false)
		$AudioStreamPlayer2D.stream = sfx_throw
		$AudioStreamPlayer2D.play()

func _on_AudioStreamPlayer2D_finished():
	destroy()
