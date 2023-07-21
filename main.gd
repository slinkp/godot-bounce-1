extends Node

@export var ball_scene: PackedScene

@export var speed = 1000.0

# Called when the node enters the scene tree for the first time.
func _ready():
	restart_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func restart_game():
	stop_game()
	# Hacky `sleep` to wait for all to be freed
	await get_tree().create_timer(0.5).timeout
	print("Starting game")
	add_random_ball()

func stop_game():
	print("Stopping")
	get_tree().call_group("balls", "queue_free")

func add_random_ball():
	var new_ball = ball_scene.instantiate()
	new_ball.position = random_position()
	print("New ball position %s" % new_ball.position)

	new_ball.rotation = random_rotation()

	var direction = new_ball.rotation # Vector2(PI, PI)
	var velocity = Vector2(speed, 0.0)
	new_ball.linear_velocity = velocity.rotated(direction)

	add_child(new_ball)


func random_position():
	# Unclear why get_viewport_rect() wasn't available here?
	# TODO: ensure we don't overlap with walls.
	var rect = get_tree().root.get_visible_rect()
	print("Got rect %s" % rect)
	var position = Vector2(
		# TODO: Get rectangle enclosed by WallContainer?
		randf_range(50, 950),
		randf_range(50, 200)
		)
	return position # print("Setting position to %s" % position)


func random_rotation():
	# Randomize direction
	var direction = randf_range(0, PI * 2)
	return direction


func _on_stop_button_button_down():
	stop_game()


func _on_restart_button_button_down():
	restart_game()


func _on_ball_spawn_button_button_down():
	add_random_ball()


func _on_ui_speed_updated(new_speed):
	print("Changing speed from %s to %s" % [speed, new_speed])
	speed = new_speed
