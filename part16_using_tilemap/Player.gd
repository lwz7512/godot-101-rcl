extends KinematicBody2D


const ACCEL = 1500
const MAX_SPEED = 500
const FRICTION = -500
const GRAVITY = 500
const WALK_SPEED = 200

var acc = Vector2()
var vel = Vector2(0, 0)


func _ready():
	pass

func _physics_process(delta):
	# add gravity
	acc.y = GRAVITY
	# if left pressed: `-1`; if right pressed: `1`; if no pressed: `0`
	acc.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	# give it a speed
	acc.x *= ACCEL
	# slowdown speed if no key pressed
	if acc.x == 0:
		acc.x = vel.x * FRICTION * delta
	
	# change speed by time
	vel += acc * delta
	# restrict speed
	vel.x = clamp(vel.x, -MAX_SPEED, MAX_SPEED)
	vel.y = clamp(vel.y, -MAX_SPEED, MAX_SPEED)
	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.
	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
	move_and_slide(vel)
