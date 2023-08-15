extends Node

# Twelfth root of two = one semitone in equal temperament.
# See eg https://dbpedia.org/page/Twelfth_root_of_two
var semitone_freq_ratio: float = pow(2.0, (1.0 / 12.0))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func handle_hit(body, hit_position):
	# Random sound engine!
	send_osc(hit_position)


func send_osc(hit_position):
	var peer = PacketPeerUDP.new()
	peer.set_dest_address("127.0.0.1", 6449) # Hardcoded to chuck OSC demo
	var pitch = midi_pitch_from_x_position(hit_position.x)
	var bytes = osc_message(pitch)
	peer.put_packet(bytes)

func osc_message(pitch) -> PackedByteArray:
	# We use a StreamPeerBuffer because that's the only way I can find
	# to force encoding an int as bigendian bytes.
	# I would rather use a PackedByteArray differently, it's simpler.
	var bytes = StreamPeerBuffer.new()
	bytes.big_endian = true
	bytes.resize(256)  # Hack to ensure plenty of room.TODO what's the default?

	var velocity = 100

	var args = [pitch, velocity] # MIDI style, 0-127
	var osc_path = "/note/on"  # TODO also support /note/off. But when?

	bytes.put_data(osc_string_as_bytes(osc_path))

	var typetag = ","
	for arg in args:
		if arg is int:
			typetag += "i"
		elif arg is String:
			typetag += "s"
		else:
			printerr("Unhandled type for OSC type tag %" % arg)

	bytes.put_data(osc_string_as_bytes(typetag))

	for arg in args:
		# TODO this only handles ints
		if arg is int:
			bytes.put_32(arg)
		elif arg is String:
			bytes.put_data(osc_string_as_bytes(arg))
		else:
			printerr("Unhandled type for OSC data %" % arg)

	bytes.resize(bytes.get_position())
	bytes.seek(0)
	var message = bytes.data_array
	print("Message size is %s: %s" % [message.size(), message])
	return message


func osc_int_as_bytes(i):
	# 32-bit big-endian two’s complement integer
	# We just rely on the caller to be big-endian
	return i

func osc_string_as_bytes(s) -> PackedByteArray:
	var b = s.to_ascii_buffer()
	var padsize = 4 - (b.size() % 4)
	for i in range(padsize):
		b.append(0)
	return b


func semitone_offset_from_x_position(x: int) -> int:
	# Spread some octaves over the x coords.
	# Returns an int -12, 12.
	var semitone_range = 24
	# Center of wall = base pitch.
	# Right end = 1 octave up, left end = 1 octave down.
	# So, map position x to the range (-12, 12)
	var screen_width: float = 1100.0  # TODO get from viewport
	var semitone = (x / screen_width) * semitone_range
	semitone = int(round(semitone))
	# Offset so center of screen is sample's base pitch, ie
	# ie center is zero semitones = unchanged from orig sample.
	semitone -= (semitone_range / 2)
	print("Got semitone %s from position %s" % [semitone, x])
	return semitone

func midi_pitch_from_x_position(x: int, base=60) -> int:
	return base + semitone_offset_from_x_position(x)

func pitch_scale_from_x_position(x : int) -> float:
	var semitone = semitone_offset_from_x_position(x)
	var pitch_ratio: float = pow(semitone_freq_ratio, semitone)
	print("Got pitch ratio %s from position %s" % [pitch_ratio, x])
	return pitch_ratio
