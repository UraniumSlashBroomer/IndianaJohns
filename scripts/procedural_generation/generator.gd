extends Node2D

@export var unit_size : int = 16
@export var grid_size_x : int = 30
@export var grid_size_y : int = 30
@export var roomcnt : int = 5
var is_room : Array[Array] # stores info about placed rooms
var packed_room : PackedScene

	
func _ready() -> void:
	packed_room = load("res://scenes/room.tscn")
	generate_rooms()


func generate_rooms() -> void:
	var x : int
	var y : int
	for i in range(roomcnt):
		x = randi() % grid_size_x
		y = randi() % grid_size_y
		# todo: check for room overlap
		place_room(Vector2i(x, y))


func place_room(pos : Vector2i) -> bool:
	var room_instance : Room = packed_room.instantiate()
	add_child(room_instance)
	room_instance.position = pos * unit_size
	register_room(pos, room_instance.size)
	
	return true


func register_room(pos : Vector2i, size : Vector2i) -> void:
	var left = clampi(pos.x - size.x / 2, 0, grid_size_x)
	var right = clampi(pos.x + size.x / 2, 0, grid_size_x)
	var bottom = clampi(pos.y - size.y / 2, 0, grid_size_y)
	var up = clampi(pos.y + size.y / 2, 0, grid_size_y)

	for i in range(up, bottom):
		for j in range(left, right):
			is_room[i][j] = true

