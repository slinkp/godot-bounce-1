extends Control

signal speed_updated(speed: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_speed_line_edit_text_submitted(new_text: String):
	new_text = new_text.strip_edges()
	if new_text.is_valid_int():
		speed_updated.emit(new_text.to_int())
	else:
		printerr("Invalid speed %s" % new_text) # Replace with function body.
