extends Sprite

var vel = Vector2(100, 50)

func _ready():
	print(position)
	set_process(true)

func _process(delta):
	rotation = rotation + PI * delta
	position += vel * delta
