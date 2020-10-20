# KinematicBody2D Collision demo
# KidsCanCode 2017

extends KinematicBody2D

var speed = 200
var vel = Vector2() # pixels/sec

# set this to < 1.0 to demonstrate loss of energy
var bounce_coefficent = 1.0
# this toggles reflect or slide mode
var reflect = true

func _ready():
	#randomize()
	vel = (get_viewport().get_mouse_position() - position).normalized() * speed

func _physics_process(delta):
	# move the body
	var collision = move_and_collide(vel * delta)
	if collision:
		if reflect:
			# reflect the motion *and* the velocity
			vel = vel.bounce(collision.normal)
		else:
			# or slide them
			vel = move_and_slide(vel)



func _on_visible_screen_exited():
	queue_free()
