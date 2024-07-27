extends CharacterBody2D

@export var MAX_SPEED = 300
@export var FRICTION: float = 1200
@export var ACCELERATION = 1500


@onready var axis = Vector2.ZERO
@onready var sprite = $AnimatedSprite2D


func _ready():
	pass
	
func _process(delta):
	sprite.play('idle_S')
	axis = get_input_axis()


func _physics_process(delta):

	move()


func get_input_axis():

	axis.x = int(Input.is_action_pressed('move_right')) - int(Input.is_action_pressed('move_left'))
	axis.y = int(Input.is_action_pressed('move_down')) - int(Input.is_action_pressed('move_up'))
	return axis.normalized()

func move():

	if axis == Vector2.ZERO:
		apply_fiction(FRICTION)
	elif axis != Vector2.ZERO:
		apply_movement(axis * ACCELERATION)

	move_and_slide()


func apply_fiction(amount):

	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO


func apply_movement(accel):

	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)
