extends State
class_name Move_state

@export var sprite : AnimatedSprite2D

var dir_to_anim : Dictionary = {
	Vector2i(1, 1): 'run_SE',
	Vector2i(1, 0): 'run_E',
	Vector2i(0, 1): 'run_S',
	Vector2i(0, -1): 'run_N',
	Vector2i(-1, 0): 'run_W',
	Vector2i(-1, -1): 'run_NW',
	Vector2i(-1, 1): 'run_SW',
	Vector2i(1, -1): 'run_NE'
}

func Update(_delta: float):
	var input_x = round(Input.get_axis("move_left", "move_right"))
	var input_y = round(Input.get_axis("move_up", "move_down"))
	if !(input_x == 0 and input_y == 0):
		sprite.play(dir_to_anim[Vector2i(input_x, input_y)])
	else:
		fsm.change_state("Idle_state")
