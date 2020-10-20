extends RigidBody2D

var thrust = Vector2(0, 250)
var torque = 2000

func _ready():
	pass

# Called during physics processing, 
# allowing you to read and safely modify the simulation state for the object.
func _integrate_forces(state):
	if Input.is_action_pressed("ui_up"):
		set_applied_force(state.get_total_gravity() + thrust.rotated(rotation))
	else:
		set_applied_force(state.get_total_gravity() + Vector2())
	var t = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	set_applied_torque(torque * t)
