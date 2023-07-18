
Initial scene plan and expected scene types:

- Main ... just a plain Node to attach things to?

- Ball - RigidBody2D
  - get ideas from "instancing" demo Ball.tscn
  - contains a Sprite2D node, configure it with a ball image, could copy the same one
  - contains a CollisionShape2D
- WallsContainer - Node?
  - Wall (multiple copies): StaticBody2D
    - contains: Sprite2D with some wall-ish image; could copy same one
    - contains: CollisionShape2D
- Bounce sound(s) - AudioStreamPlayer
