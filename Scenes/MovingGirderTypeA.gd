extends Node2D

export var speed_magnitude = 10
var speed = speed_magnitude

func break_left_rope():
	$LeftRopeJoint.queue_free()
	$LeftRope.queue_free()

func _process(delta):
	if $LeftRope.position.x > 100:
		speed = -speed_magnitude
	elif $LeftRope.position.x < 4:
		speed = speed_magnitude

	$LeftRope.position.x += speed * delta
	$RightRope.position.x += speed * delta
