extends StaticBody2D

var bus = "master"
var player: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	load_sound()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func handle_hit(position):
	make_sound(position)


func make_sound(position):
	print("Beep! %s" % name)
	var pitch_scale = randfn(0.5, 2.0)
	# print("Stream is %s" % player.has_stream_playback())
	player.pitch_scale = pitch_scale
	player.play()


func load_sound():
	var path = "res://assets/sounds/drum-hit-tom-low_100bpm_D#_major.wav"
	player = AudioStreamPlayer.new()
	add_child(player)
	player.bus = bus
	if FileAccess.file_exists(path):
		print("Loading %s" % path)
		var stream = load(path)
		player.set_stream(stream)
	else:
		print("Could not load path %s" % path)
