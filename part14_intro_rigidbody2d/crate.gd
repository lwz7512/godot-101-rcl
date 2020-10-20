extends RigidBody2D

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var dir = (get_viewport().get_mouse_position() - position).normalized()
		apply_impulse(Vector2(), dir * 800)
