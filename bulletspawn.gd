extends Spatial


const bullet_scene = preload("res://bullet.tscn")
onready var shoot_timer = $Timer
onready var rotater = $Rotater
onready var bullet_area = $Area

const rotate_speed = Vector3(100, 0, 0)
const wave_time = 1
var spawn_count = 12
const radius = 100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var step = 2 * PI / spawn_count
	
	for i in range(spawn_count):
		var spawn_point = Spatial.new()
		var pos = spawn_point.transform.rotated(Vector3.UP, step * i)
		spawn_point.transform = pos
		rotater.add_child(spawn_point)
		print(rotater.transform)
		print(step)
		
	bullet_area.connect("area_exited", self, "_on_Bullet_exit")

	shoot_timer.wait_time = wave_time
#	shoot_timer.start()
	
func _process(delta: float) -> void:
	var new_rotation = rotater.transform.rotated(Vector3.UP, .3 * delta)
	rotater.transform = new_rotation

func _on_Timer_timeout() -> void:
	for s in rotater.get_children():
		var bullet = bullet_scene.instance()
		add_child(bullet)
		bullet.transform.origin = s.global_transform.origin
		bullet.transform.basis = s.global_transform.basis

func _on_Bullet_exit(collider: Area) -> void:
	var bullet = collider.get_parent()
	if bullet.is_class("Sprite3D"):
		bullet.queue_free()
		print("exited")
	else:
		print(bullet.get_class())


func _on_Area_area_entered(area: Area) -> void:
	var player = area.get_parent()
	if player.is_class("KinematicBody"):
		shoot_timer.start()
