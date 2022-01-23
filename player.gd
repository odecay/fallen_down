extends KinematicBody
var magnitude = 2.4
var is_standing: bool =	1


var gravity = Vector3.DOWN * 12
#var gravity = -12
var speed = 20
var velocity = Vector3.ZERO
#var max_speed = 160.0
var max_speed = 50.0
onready var hex_orbs = [$HexOrb0, $HexOrb1, $HexOrb2, $HexOrb3, $HexOrb4, $HexOrb5]
var hex_positions = [
	Vector3(2, 0, 0),
	Vector3(-2, 0, 0),
	Vector3(1, 0, 2),
	Vector3(1, 0, -2),
	Vector3(2, 0, 1),
	Vector3(-2, 0, 1)
]


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
	#velocity = velocity.normalized() * max_speed*.75
	velocity.y = velocity.y * 1.2
	
func particle_stream():
	$Particles.emitting = true
	$HitSound.play()

func get_position():
	return global_transform

func get_last_orb_position():
	var orb = hex_orbs.back()
	return orb.global_transform

func orb_remove() -> Node:
		var orb = hex_orbs.pop_back()
		remove_child(orb)
		return orb

func orb_add(orb: Node):
	#add_child(orb)
	var position = orb.global_transform
	orb.transform = position
	hex_orbs.append(orb)
	
func has_orbs() -> bool:
	if hex_orbs.empty():
		return false
	else:
		return true

