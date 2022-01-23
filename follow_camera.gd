extends Camera

export var lerp_speed = 3.0
export (NodePath) var target_path = null
export (Vector3) var offset = Vector3.ZERO

var target = null

func _ready():
	if target_path:
		target = get_node(target_path)

func _physics_process(delta):
	if !target:
		return
	var target_pos = target.global_transform.translated(offset)
	target_pos.basis = (Basis(Vector3.RIGHT, Vector3.FORWARD, Vector3.UP))
	global_transform = global_transform.interpolate_with(target_pos, lerp_speed * delta)
#	global_transform.basis.y = Vector3.UP
#	global_rotate(Vector3.RIGHT, -90)
#	look_at(target.global_transform.origin, Vector3.UP)
#	global_transform = global_transform.orthonormalized()
