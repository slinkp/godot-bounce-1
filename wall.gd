extends StaticBody2D

var bus = "master"
var bus_mapping = {
	"wall_t": "top",
	"wall_r": "right",
	"wall_b": "bottom",
	"wall_l": "left",
}
var player: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	load_sound(name)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func handle_hit(hit_position):
	make_sound(hit_position)


func make_sound(hit_position):
	# print("Beep! %s" % name)
	var pitch_scale = randfn(0.5, 2.0)
	# print("Stream is %s" % player.has_stream_playback())
	player.pitch_scale = pitch_scale
	player.play()


func get_sound_path(nodename):
	return "res://assets/sounds/drum-hit-tom-low_100bpm_D#_major.wav"

func load_sound(nodename):
	var path = get_sound_path(nodename)
	player = AudioStreamPlayer.new()
	add_child(player)
	var bus_name = bus_mapping[nodename]
	player.bus = bus_name
	if FileAccess.file_exists(path):
		var stream = load(path)
		player.set_stream(stream)
		print("Loaded sound from %s" % path)
	else:
		printerr("Could not load path %s" % path)
