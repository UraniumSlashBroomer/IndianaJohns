extends State
class_name IdleState

@export var sprite: AnimatedSprite2D


func enter():
	sprite.play("idle_S")


func _process(_delta: float):
	if (Input.get_vector("move_left", "move_right", "move_up", "move_down")):
		fsm.change_state("MoveState")
