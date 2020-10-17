extends Area2D

export var speed = 400

var screensize
var extents
var vel = Vector2()

func _ready():
	screensize = get_viewport_rect().size
	extents = get_node("collision").get_shape().get_extents()
	position = screensize / 2

func _process(delta):
	var input = Vector2(0, 0)
	
	if Input.is_action_pressed('ui_right'):
		input.x += 1
	if Input.is_action_pressed('ui_left'):
		input.x -= 1
	if Input.is_action_pressed('ui_down'):
		input.y += 1
	if Input.is_action_pressed('ui_up'):
		input.y -= 1
	
	vel = input.normalized() * speed
	
	var pos = position + vel * delta
	
	# print("-------------------------------")
	# print("Bef: " + String(pos.x) + "," + String(extents.x) + "," + String(screensize.x - extents.x))

	pos.x = clamp(pos.x, extents.x, screensize.x - extents.x)
	pos.y = clamp(pos.y, extents.y, screensize.y - extents.y)
	
	# print("Aft " + String(pos.x))
	# update position with new position
	position = pos
