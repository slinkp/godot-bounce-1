
Initial scene plan and expected scene types:

- Main ... just a plain Node to attach things to?

- Ball - RigidBody2D
  - get ideas from "instancing" demo Ball.tscn
    - also this tutorial for zero gravity bouncing https://www.youtube.com/watch?v=vRiCBsAgTG4
  - contains a Sprite2D node, configure it with a ball image, could copy the same one
  - contains a CollisionShape2D
- WallsContainer - Node?
  - Wall (multiple copies): StaticBody2D
    - contains: Sprite2D with some wall-ish image; could copy same one
      ... i'd really like to just fill a rectangle with color but unsure how to
      do that so i'll just use a png.
    - contains: CollisionShape2D
- Bounce sound(s) - AudioStreamPlayer


TODO: read about `apply_impulse` and `apply_force` methods, maybe useful later
to start inert bodies moving?

TODO:
Who should handle the "hit" signal?
If each wall has a different sound, maybe the wall.


# Way to change source file of an AudioStreamPlayer dynamically

Found this at https://www.youtube.com/watch?v=A-926oL_8NM
You could obviously refactor to pass in filename, and so forth.
```
func start_sound():
    var path = "res://sounds/thingy.mp3"
    var file = File.new()
    if file.file_exists(path):
        file.open(path, file.READ)
        var buffer = file.get_buffer(file.get_len())
        var stream = AudioStreamMP3.new()
        stream.data = buffer
        # Assumes this script's parent has an AudioStreamPlayer child
        var audio = get_parent().get_node("AudioStreamPlayer")
        audio.stream = stream
        audio.play
```
