extends RigidBody
var magnitude = 1.3
var is_standing: bool =	1


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _integrate_forces(state):
	if Input.is_action_pressed("ui_down"):
		add_force(Vector3.BACK*magnitude,global_transform.origin)
	if Input.is_action_pressed("ui_up"):
		add_force(Vector3.FORWARD*magnitude,global_transform.origin)
	if Input.is_action_pressed("ui_left"):
		add_force(Vector3.LEFT*magnitude,global_transform.origin)
	if Input.is_action_pressed("ui_right"):
		add_force(Vector3.RIGHT*magnitude,global_transform.origin)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
