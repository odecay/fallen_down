extends KinematicBody
var magnitude = 2.4
var is_standing: bool =	1


export var gravity = Vector3.DOWN * 14
export var speed = 20

var velocity = Vector3.ZERO
var max_speed = 200.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity += gravity * delta
	var s_speed = velocity.length()
	if s_speed > max_speed:
		velocity = velocity.normalized() * max_speed
		
	get_input(delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	
func get_input(delta):
	var vy = velocity.y
	velocity = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity += -transform.basis.z * speed
	if Input.is_action_pressed("ui_down"):
		velocity += transform.basis.z * speed
	if Input.is_action_pressed("ui_left"):
		velocity += -transform.basis.x * speed
	if Input.is_action_pressed("ui_right"):
		velocity += transform.basis.x * speed
	velocity.y = vy
	
func slow():
	velocity = velocity.normalized() * max_speed/4
func boost():
	velocity = velocity.normalized() * max_speed
	
func particle_stream():
	$Particles.emitting = true
