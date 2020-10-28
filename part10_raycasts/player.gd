extends KinematicBody2D

onready var ground_ray = get_node("ground_ray")

const ACCEL = 1500
const MAX_SPEED = 500
const FRICTION = -500
const GRAVITY = 800
const JUMP_SPEED = -1000
const MIN_JUMP = -100

var acc = Vector2()
var vel = Vector2()

func _ready():
	pass

func _input(event):
	# if we dont have ground ray check, we would be flying after couples key pressing
	if event.is_action_pressed("ui_select") and ground_ray.is_colliding():
		vel.y = JUMP_SPEED
	if event.is_action_released("ui_select"):
		vel.y = clamp(vel.y, MIN_JUMP, vel.y)

func _physics_process(delta):
	acc.y = GRAVITY
	acc.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	acc.x *= ACCEL
	if acc.x == 0:
		acc.x = vel.x * FRICTION * delta

	vel += acc * delta
	vel.x = clamp(vel.x, -MAX_SPEED, MAX_SPEED)

	move_and_slide(vel)
