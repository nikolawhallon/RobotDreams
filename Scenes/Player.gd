extends KinematicBody2D

signal wake_up
signal infinite_bombs_collected
var infinite_bombs_collected = false

export var camera_limit_bottom = 10000000
export var camera_limit_left = -10000000
export var camera_limit_right = 10000000
export var gravity = 10
export var run_speed = 100
export var jump_speed = 260
export var wake_speed = 425
var velocity = Vector2.ZERO
var direction = Vector2.LEFT
var input_disabled = false

func _ready():
	$Camera2D.limit_bottom = camera_limit_bottom
	$Camera2D.limit_left = camera_limit_left
	$Camera2D.limit_right = camera_limit_right

func _input(_event):
	if Input.is_action_just_pressed("bomb") and !input_disabled and infinite_bombs_collected:
		var lit_bomb = load("res://Scenes/BombLit.tscn").instance()
		if direction == Vector2.LEFT:
			lit_bomb.global_position = global_position + Vector2(-16, -8)
			lit_bomb.apply_impulse(Vector2.ZERO, Vector2(-100, -100))
		elif direction == Vector2.RIGHT:
			lit_bomb.global_position = global_position + Vector2(16, -8)
			lit_bomb.apply_impulse(Vector2.ZERO, Vector2(100, -100))
		get_parent().add_child(lit_bomb)
	if Input.is_action_just_pressed("skip"):
		emit_signal("wake_up")

func _physics_process(_delta):
	velocity.y += gravity

	if Input.is_action_pressed("jump") and !input_disabled:
		if is_on_floor():
			velocity.y -= jump_speed
			
	if Input.is_key_pressed(KEY_A) and !input_disabled:
		velocity.x = -run_speed
	elif Input.is_key_pressed(KEY_D) and !input_disabled:
		velocity.x = run_speed
	else:
		velocity.x = 0

	var velocity_before_collision = velocity

	velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)

	if velocity.x > 0:
		if is_on_floor():
			$AnimatedSprite.animation = "walk"
		else:
			if $AnimatedSprite.animation != "air":
				$AnimatedSprite.animation = "jump"
		$AnimatedSprite.scale.x = -1
		direction = Vector2.RIGHT
	elif velocity.x < 0:
		if is_on_floor():
			$AnimatedSprite.animation = "walk"
		else:
			if $AnimatedSprite.animation != "air":
				$AnimatedSprite.animation = "jump"
		$AnimatedSprite.scale.x = 1
		direction = Vector2.LEFT
	else:
		if is_on_floor():
			$AnimatedSprite.animation = "idle"
		else:
			if $AnimatedSprite.animation != "air":
				$AnimatedSprite.animation = "jump"

	if !is_on_floor() and velocity_before_collision.length() > wake_speed:
		$AnimatedSprite.animation = "fall"

	if get_slide_count() > 0 and velocity_before_collision.length() > wake_speed:
		emit_signal("wake_up")

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "jump":
		$AnimatedSprite.animation = "air"
