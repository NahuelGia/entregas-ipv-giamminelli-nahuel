extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween().set_loops()
	tween.tween_property(self, "color", Color.RED, 1.0)
	tween.tween_property(self, "color", Color.BLUE, 1.0)
	tween.tween_property(self, "color", Color.GREEN, 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
