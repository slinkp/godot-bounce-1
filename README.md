
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
