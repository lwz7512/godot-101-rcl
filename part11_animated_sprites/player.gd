extends KinematicBody2D

onready var ground_ray = get_node("ground_ray")
onready var sprite = get_node("sprite")

const ACCEL = 1500
const MAX_SPEED = 500
const FRICTION = -500
const GRAVITY = 2000
const JUMP_SPEED = -1000
const MIN_JUMP = -500

var acc = Vector2()
var vel = Vector2()
var anim = "idle"

func _ready():
	sprite.set_flip_h(false)

func _input(event):
	if event.is_action_pressed("ui_up") and ground_ray.is_colliding():
		vel.y = JUMP_SPEED
	if event.is_action_released("ui_up"):
		vel.y = clamp(vel.y, MIN_JUMP, vel.y)

func _physics_process(delta):
	acc.y = GRAVITY
	acc.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	acc.x *= ACCEL
	
	# slowdown moving if no left and right
	if acc.x == 0:
		acc.x = vel.x * FRICTION * delta
	
	# increasing speed with acceleration 
	vel += acc * delta
	
	# if horizontal move, reduce gravity ?
	if acc.x > 0 and ground_ray.is_colliding():
		print('>>>> moving on board...')
		vel.y = 0
	
	# fix horizontal speed
	vel.x = clamp(vel.x, -MAX_SPEED, MAX_SPEED)
	
	# move with speed
	move_and_slide(vel)
	
	# if stop moving then stop animation
	if abs(vel.x) < 10:
		vel.x = 0
	
	# set animation
	if vel.x == 0:
		anim = "idle"
	else:
		anim = "running"
	if vel.x > 0:
		sprite.set_flip_h(false)
	elif vel.x < 0:
		sprite.set_flip_h(true)
	sprite.play(anim)
