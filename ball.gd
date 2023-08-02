extends RigidBody2D


var screen_size

signal handle_hit(body, position)

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	# Don't allow going off screen!
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)


func _on_body_entered(body):
	if body.name.contains("wall"):
		emit_signal("handle_hit", body, position)
	else:
		print("Hit a non-wall %s" % body.name)

