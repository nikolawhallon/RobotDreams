extends KinematicBody2D

signal wake_up

export var gravity = 10
export var run_speed = 100
export var jump_speed = 250
var velocity = Vector2.ZERO
var direction = Vector2.LEFT

func _physics_process(_delta):
	if !is_on_floor():
		velocity.y += gravity

	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y -= jump_speed
			
	if Input.is_key_pressed(KEY_A):
		velocity.x = -run_speed
	elif Input.is_key_pressed(KEY_D):
		velocity.x = run_speed
	else:
		velocity.x = 0

	var velocity_before_collision = velocity

	velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)

	if velocity.x > 0:
		$Sprite.scale.x = -1
		direction = Vector2.RIGHT
	elif velocity.x < 0:
		$Sprite.scale.x = 1
		direction = Vector2.LEFT

	if get_slide_count() > 0 and velocity_before_collision.length() > 450:
		emit_signal("wake_up")
