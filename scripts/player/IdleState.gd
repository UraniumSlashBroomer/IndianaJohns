extends State
class_name Idle_state

@export var sprite: AnimatedSprite2D
var last_input : Vector2i

var dir_to_anim : Dictionary = {
	Vector2i(1, 1): "idle_S",
	Vector2i(1, 0): "idle_E",
	Vector2i(1, -1): "idle_N",
	Vector2i(0, 1): "idle_S",
	Vector2i(0, -1): "idle_N",
	Vector2i(-1, 0): "idle_W",
	Vector2i(-1, -1): "idle_N",
	Vector2i(-1, 1): "idle_S",
	Vector2i(0, 0): "idle_S",
}

func enter():
	sprite.play(dir_to_anim[last_input])


func _process(_delta: float):
	if (Input.get_vector("move_left", "move_right", "move_up", "move_down")):
		fsm.change_state("MoveState")
