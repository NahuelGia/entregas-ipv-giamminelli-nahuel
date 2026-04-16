extends StaticBody2D

@onready var fire_position: Node2D = $FirePosition
@onready var fire_timer: Timer = $FireTimer
@onready var detection_area: Area2D = $DetectionArea
@onready var player_ray_cast: RayCast2D = $PlayerRayCast
@onready var hitbox: Area2D = $Hitbox

@export var projectile_scene: PackedScene

var player: Node2D
var projectile_container: Node


func initialize(turret_pos: Vector2, projectile_container: Node) -> void:
	global_position = turret_pos
	self.projectile_container = projectile_container
	fire_timer.connect("timeout", fire_at_player)
	detection_area.body_entered.connect(_on_body_entered)
	detection_area.body_exited.connect(_on_body_exited)
	hitbox.area_entered.connect(_on_hitbox_area_entered)
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("player"):
		queue_free()
	
func has_line_of_sight() -> bool:
	player_ray_cast.target_position = to_local(player.global_position)
	player_ray_cast.force_raycast_update()
	if player_ray_cast.is_colliding():
		return player_ray_cast.get_collider() == player
	return false

func fire_at_player() -> void:
	if player == null:
		return
	if not has_line_of_sight():
		return
	var proj_instance = projectile_scene.instantiate()
	proj_instance.initialize(
		projectile_container,
		fire_position.global_position,
		fire_position.global_position.direction_to(player.global_position),
		self
	)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		fire_timer.start()

func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
		fire_timer.stop()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
 	
