extends Sprite2D

@onready var lifetime_timer = $LifetimeTimer

@export var VELOCITY: float = 800.0

@onready var hit_area: Area2D = $HitArea 

var direction:Vector2
var shooter: Node

func initialize(container, spawn_position:Vector2, direction:Vector2, shooter: Node):
	container.add_child(self)
	self.direction = direction
	self.shooter = shooter
	global_position = spawn_position
	lifetime_timer.connect("timeout", Callable(self, "_on_lifetime_timer_timeout"))
	lifetime_timer.start()
	hit_area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body is PhysicsBody2D and body != shooter:
		_remove()

func _physics_process(delta):
	position += direction * VELOCITY * delta
	
	var camera: Camera2D = get_viewport().get_camera_2d()
	var screen_size: Vector2 = get_viewport().get_visible_rect().size
	var visible_rect: Rect2 = Rect2(
		camera.global_position - screen_size / 2,
		screen_size)
	
	if !visible_rect.has_point(global_position):
		_remove()


func _on_lifetime_timer_timeout():
	_remove()

func _remove():
	get_parent().remove_child(self)
	queue_free()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
