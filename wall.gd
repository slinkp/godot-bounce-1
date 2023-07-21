extends StaticBody2D

var bus = "master"
var bus_mapping = {
	"wall_t": "top",
	"wall_r": "right",
	"wall_b": "bottom",
	"wall_l": "left",
}
var player: AudioStreamPlayer

# Twelfth root of two = one semitone in equal temperament.
# See eg https://dbpedia.org/page/Twelfth_root_of_two
var semitone_freq_ratio: float = pow(2.0, (1.0 / 12.0))

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Semitone freq ratio: %s" % semitone_freq_ratio)
	load_sound(name)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func handle_hit(hit_position):
	make_sound(hit_position)


func pitch_scale_from_x_position(x : int) -> float:
	# Spread some octaves over the x coords.
	var semitone_range = 24
	# Center of wall = base pitch of sample.
	# Right end = 1 octave up, left end = 1 octave down.
	# So, map position x to the range (-12, 12)
	var screen_width: float = 1100.0  # TODO get from viewport
	var semitone = (x / screen_width) * semitone_range
	semitone = int(round(semitone))
	# Offset so center of screen is sample's base pitch, ie
	# ie center is zero semitones = unchanged from orig sample.
	semitone -= (semitone_range / 2)
	print("Got semitone %s from position %s" % [semitone, x])
	var pitch_ratio: float = pow(semitone_freq_ratio, semitone)
	print("Got pitch ratio %s from position %s" % [pitch_ratio, x])
	return pitch_ratio


func make_sound(hit_position):
	# TODO: make this work for y on the left/right walls too
	var pitch_scale = pitch_scale_from_x_position(hit_position.x)
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
