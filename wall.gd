extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	load_sound()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func handle_hit(position):
	make_sound()


func make_sound():
	print("Beep! %s" % name)
	print("Stream is %s" % $AudioStreamPlayer.has_stream_playback())
	$AudioStreamPlayer.play()


func load_sound():
	var path = "res://assets/sounds/drum-hit-tom-low_100bpm_D#_major.wav"
	if FileAccess.file_exists(path):
		print("Loading %s" % path)
		var file = FileAccess.open(path, FileAccess.READ)
		var buffer = file.get_buffer(file.get_length())
		var stream = AudioStreamMP3.new()
		stream.data = buffer
		# Assumes this script's parent has an AudioStreamPlayer child
		# # get_parent().get_node("AudioStreamPlayer")
		$AudioStreamPlayer.set_stream(stream)
	else:
		print("Could not load path %s" % path)
