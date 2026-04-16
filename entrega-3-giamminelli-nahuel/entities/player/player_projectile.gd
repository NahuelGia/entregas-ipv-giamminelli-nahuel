extends Sprite2D

@onready var lifetime_timer = $LifetimeTimer

@export var VELOCITY: float = 800.0

@onready var hit_area: Area2D = $HitArea 

var direction:Vector2

func initialize(container, spawn_position:Vector2, direction:Vector2):
	container.add_child(self)
	self.direction = direction
	global_position = spawn_position
	lifetime_timer.connect("timeout", Callable(self, "_on_lifetime_timer_timeout"))
	lifetime_timer.start()
	hit_area.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node) -> void:
	if body is PhysicsBody2D and not body.is_in_group("player"):
		_remove()

func _physics_process(delta):
	position += direction * VELOCITY * delta
	
	var camera: Camera2D = get_viewport().get_camera_2d()
	var screen_size: Vector2 = get_viewport().get_visible_rect().size
	var visible_rect: Rect2 = Rect2(
		camera.global_position - screen_size / 2,
		screen_size)

func _on_lifetime_timer_timeout():
	_remove()

func _remove():
	get_parent().remove_child(self)
	queue_free()
	
