extends Node

@export var ball_scene: PackedScene

var speed = 3000.0

# Called when the node enters the scene tree for the first time.
func _ready():
	restart_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func restart_game():
	print("Restarting")
	add_random_ball()


func add_random_ball():
	var new_ball = ball_scene.instantiate()
	new_ball.position = random_position()
	print("Got position %s" % new_ball.position)

	new_ball.rotation =random_rotation()

	var direction = new_ball.rotation # Vector2(PI, PI)
	var velocity = Vector2(speed, 0.0)
	new_ball.linear_velocity = velocity.rotated(direction)

	add_child(new_ball)


func random_position():
	# Unclear why I had to do this instead of
	# just calling get_viewport_rect()?
	# TODO: ensure we don't overlap with walls.
	var rect = get_tree().root.get_visible_rect()
	print("Got rect %s" % rect)
	var position = Vector2(
		randf_range(0, rect.end.x),
		randf_range(0, rect.end.y)
		)
	return position # print("Setting position to %s" % position)


func random_rotation():
	# Randomize direction
	var direction = randf_range(0, PI * 2)
	return direction
