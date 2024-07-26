extends CharacterBody2D

@export var MAX_SPEED = 300
@export var FRICTION: float = 1200
@export var ACCELERATION = 1500

@onready var axis = Vector2.ZERO
@onready var sprite = $AnimatedSprite2D
@onready var lastPressed: String

func _ready():

	sprite.play('idle_S')


func _process(delta):

	axis = get_input_axis()


func _physics_process(delta):

	move()
	animation()


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


func animation():

	if Input.is_action_pressed('move_up') and Input.is_action_pressed('move_right'):
		sprite.play('run_NE')
		lastPressed = 'NE'
	elif Input.is_action_pressed('move_up') and Input.is_action_pressed('move_left'):
		sprite.play('run_NW')
		lastPressed = 'NW'
	elif Input.is_action_pressed('move_down') and Input.is_action_pressed('move_left'):
		sprite.play('run_SW')
		lastPressed = 'SW'
	elif Input.is_action_pressed('move_down') and Input.is_action_pressed('move_right'):
		sprite.play('run_SE')
		lastPressed = 'SE'
	elif Input.is_action_pressed('move_up'):
		sprite.play('run_N')
		lastPressed = 'N'
	elif Input.is_action_pressed('move_left'):
		sprite.play('run_W')
		lastPressed = 'W'
	elif Input.is_action_pressed('move_down'):
		sprite.play('run_S')
		lastPressed = 'S'
	elif Input.is_action_pressed('move_right'):
		sprite.play('run_E')
		lastPressed = 'E'
	elif lastPressed == 'S':
		sprite.play('idle_S')
	elif lastPressed == 'N':
		sprite.play('idle_N')
	elif lastPressed == 'E':
		sprite.play('idle_E')
	elif lastPressed == 'W':
		sprite.play('idle_W')
	elif lastPressed == 'NE':
		sprite.play('idle_E')
	elif lastPressed == 'NW':
		sprite.play('idle_W')
	elif lastPressed == 'SW':
		sprite.play('idle_S')
	elif lastPressed == 'SE':
		sprite.play('idle_S')
	
