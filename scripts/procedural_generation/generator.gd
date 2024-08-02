extends Node2D

@export var unit_size : int = 16
@export var grid_size : Vector2i
@export var roomcnt : int = 5
var is_room : Array # stores info about placed rooms
var packed_room : PackedScene

	
func _ready() -> void:
	packed_room = load("res://scenes/rooms/room1.tscn")
	generate_rooms()
	for i in range(grid_size.y):
		var line : Array[int]
		for j in range(grid_size.x):
			line.append(0)
		is_room.append(line)




func generate_rooms() -> void:
	var rooms_placed : int = 0 
	var random_pos : Vector2i 
	while (rooms_placed != roomcnt):
		var room_instance : Room = packed_room.instantiate()

		random_pos = Vector2i(
			randi() % grid_size.x,
			randi() % grid_size.y
		)
		print(room_instance.size)
		while is_overlap(random_pos, room_instance.size):
			random_pos = Vector2i(
				randi() % grid_size.x,
				randi() % grid_size.y
			)


		add_child(room_instance)
		register_room(random_pos, room_instance.size)
		room_instance.position = (random_pos - grid_size / 2) * unit_size
		rooms_placed += 1


func register_room(pos : Vector2i, size : Vector2i) -> void:
	var left = clampi(pos.x - size.x / 2, 0, grid_size.x)
	var right = clampi(pos.x + size.x / 2, 0, grid_size.x)
	var bottom = clampi(pos.y + size.y / 2, 0, grid_size.y)
	var up = clampi(pos.y - size.y / 2, 0, grid_size.y)
	print(up)
	print(bottom)
	print(left)
	print(right)

	for i in range(up, bottom):
		for j in range(left, right):
			is_room[i][j] = 1
			print(1)
	
	


func is_overlap(pos : Vector2i, size : Vector2i) -> bool:
	var left = clampi(pos.x - size.x / 2, 0, grid_size.x)
	var right = clampi(pos.x + size.x / 2, 0, grid_size.x)
	var bottom = clampi(pos.y - size.y / 2, 0, grid_size.y)
	var up = clampi(pos.y + size.y / 2, 0, grid_size.y)

	for i in range(up, bottom):
		for j in range(left, right):
			if is_room[i][j]: return true

	return false
