extends Node2D
class_name RoomGenerator

@export var unit_size : int = 16
@export var grid_size : Vector2i
@export var roomcnt : int = 5
@export var min_space_between_rooms = 5
@export var max_bad_tries = 10000
@export var rooms_paths : Array[String]

var available_rooms : Array[PackedScene]
var placed_rooms : Array[Room]

	
func _ready() -> void:
	load_available_scenes()
	generate_rooms()


func generate_rooms() -> void:
	var rooms_placed : int = 0 
	var random_pos : Vector2i 
	var tries : int = 0
	while (rooms_placed != roomcnt):
		if tries > max_bad_tries:
			print("quit bcs of too many tries")
			break

		var room_instance : Room = get_random_room().instantiate()

		random_pos = Vector2i(
			randi() % grid_size.x,
			randi() % grid_size.y
		)

		while true:
			random_pos = Vector2i(
				randi() % grid_size.x,
				randi() % grid_size.y
			)

			tries += 1
			if tries > max_bad_tries: 
				room_instance.queue_free()
				break
			if is_overlap(random_pos, room_instance.size): 
				continue
			else:
				rooms_placed += 1
				tries = 0
				break


		add_child(room_instance)
		register_room(random_pos, room_instance)
		room_instance.position = (random_pos - grid_size / 2) * unit_size


func register_room(pos : Vector2i, room : Room) -> void:
	room.pos = pos
	placed_rooms.append(room)
	

func is_overlap(pos : Vector2i, size : Vector2i) -> bool:
	var left = pos.x - size.x / 2.0 - min_space_between_rooms
	var right = pos.x + size.x / 2.0 + min_space_between_rooms
	var up = pos.y - size.y / 2.0 - min_space_between_rooms
	var bottom = pos.y + size.y / 2.0 + min_space_between_rooms

	for room in placed_rooms:
		var l = room.pos.x - room.size.x / 2.0
		var r = room.pos.x + room.size.x / 2.0
		var u = room.pos.y - room.size.y / 2.0
		var b = room.pos.y + room.size.y / 2.0

		if bottom >= u and u >= up\
		or up <= b and b < bottom\
		or r >= left and r <= right\
		or l <= left and l >= right:
			return true

	return false


func get_random_room() -> PackedScene:
	return available_rooms[randi() % available_rooms.size()]


func load_available_scenes() -> void:
	for path in rooms_paths:
		available_rooms.append(load(path))

