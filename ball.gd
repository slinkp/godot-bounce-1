extends RigidBody2D

signal ball_hit

var screen_size

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
		print("Hit a wall! %s at %s" % [body, position])
		body.handle_hit(position)
	else:
		print("Hit something else %s" % body.name)
