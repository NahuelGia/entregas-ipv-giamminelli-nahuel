extends Node

@export var random_spawn_area: Rect2 = Rect2(0, 0, 1000, 400)

@export var turret_scene: PackedScene
@export var fixed_positions: Array[Vector2] = [
	Vector2(200, 150),
	Vector2(600, 300),
]

@onready var spawn_start: Marker2D = $SpawnStart
@onready var spawn_end: Marker2D = $SpawnEnd

func spawn_turrets(player: Node2D) -> void:
	var visible_rect: Rect2 = get_viewport().get_visible_rect()
	for pos in fixed_positions:
		spawn_turret(pos)
		
	for i in 3:
		var turret_pos: Vector2 = Vector2(
		randf_range(spawn_start.global_position.x, spawn_end.global_position.x),
		spawn_start.global_position.y )
		spawn_turret(turret_pos)
	
func spawn_turret(pos: Vector2) -> void:
	var turret_instance: Node2D = turret_scene.instantiate()
	add_child(turret_instance)
	turret_instance.initialize(pos, self)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
