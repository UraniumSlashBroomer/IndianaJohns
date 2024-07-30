extends CharacterBody2D

@export var MAX_SPEED : float = 300
@export var FRICTION: float = 1200
@export var ACCELERATION : float = 1500

@onready var axis = Vector2.ZERO


func _process(_delta):
	axis = get_input_axis()


func _physics_process(_delta):
	move()


func get_input_axis() -> Vector2:
	return Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

func move():
	if axis == Vector2.ZERO:
		apply_friction(FRICTION)
	elif axis != Vector2.ZERO:
		apply_movement(axis * ACCELERATION)

	move_and_slide()


func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO


func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)
