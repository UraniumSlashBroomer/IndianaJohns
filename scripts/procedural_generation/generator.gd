extends Node2D

@export var unit_size : int = 16
@export var grid_size_x : int = 30
@export var grid_size_y : int = 30
var grid : Array[Array]
var room_scene = preload("res://scenes/room.tscn")

func _ready() -> void:
	for i in range(grid_size_x):
		for j in range(grid_size_y):
			grid[i][j] = false
	
	
	


func place_room(pos : Vector2i) -> bool:
	var room : Room = room_scene.instantiate()
	room.position = pos * unit_size
	for i in range(pos.y - room.size.y / 2, pos.y + room.size.y / 2):
		for j in range(pos.x - room.size.x / 2, pos.x + room.size.x / 2):
			grid[i][j] = true
	
	return true

