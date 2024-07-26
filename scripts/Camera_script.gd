extends Camera2D

@export_category('Follow character')
@export var player: CharacterBody2D

@export_category('Smoothing')
@export var smoothing_enabled: bool
@export_range(0, 10) var smoothing_distance: int = 8
# func _ready():
	# if player != null:
		
func _physics_process(delta):
	if player == null:
		return
	
	var camera_position: Vector2
	
	if smoothing_enabled:
		# aprint(weight)
		camera_position = lerp(global_position, player.global_position, delta)
		print(camera_position, player.global_position)
	else:
		camera_position = player.global_position
	global_position = camera_position
	
