extends Spatial


const bullet_scene = preload("res://bullet.tscn")
onready var shoot_timer = $Timer
onready var rotater = $Rotater

const rotate_speed = Vector3(100, 0, 0)
const wave_time = 1
var spawn_count = 12
const radius = 100
var bullet_array = []
var bullet_paused_array = []
const speed = 1.5
# maybe put velocity inside process loop
var velocity = Vector3.ZERO
const direction = Vector3.FORWARD

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var bullet
	for i in range(2000):
		bullet = bullet_scene.instance()
		bullet_paused_array.append(bullet)
		bullet.pause_mode = Node.PAUSE_MODE_STOP
	var step = 2 * PI / spawn_count
	
	for i in range(spawn_count):
		var spawn_point = Spatial.new()
		var pos = spawn_point.transform.rotated(Vector3.UP, step * i)
		spawn_point.transform = pos
		rotater.add_child(spawn_point)
#		print(rotater.transform)
#		print(step)
		

	shoot_timer.wait_time = wave_time
	shoot_timer.start()
	
func _process(delta: float) -> void:
	var new_rotation = rotater.transform.rotated(Vector3.UP, .3 * delta)
	rotater.transform = new_rotation
	for bullet in bullet_array:
		velocity.x = direction.x * speed * delta
		velocity.z = direction.z * speed * delta
		bullet.transform = bullet.transform.translated(velocity)
		if bullet.transform.origin.x > 10 or bullet.transform.origin.z > 10:
			bullet_array.erase(bullet)
			bullet_stop(bullet)

func _on_Timer_timeout() -> void:
	for s in rotater.get_children():
		var bullet
#		if not bullet_paused_array.empty():
#			bullet = bullet_paused_array.pop_back()
##			bullet.pause = false
#			print("bullet_paused_array", bullet_paused_array)
#		else:
#			bullet = bullet_scene.instance()
##			print("instanced boolit")
		if not bullet_paused_array.empty():
			bullet = bullet_paused_array.pop_back()
			
		bullet.pause_mode = Node.PAUSE_MODE_PROCESS
		if not bullet.get_parent() == self:
			add_child(bullet)
		bullet_array.append(bullet)
#		bullet.transform.origin = s.global_transform.origin
#		bullet.transform.basis = s.global_transform.basis
		bullet.transform = s.global_transform

func bullet_stop(bullet : Spatial):
	bullet.pause_mode = Node.PAUSE_MODE_STOP
	bullet_paused_array.append(bullet)
	remove_child(bullet)
	
	
#func _on_Bullet_exit(collider: Area) -> void:
#	print(collider)
#	var bullet = collider.get_parent()
#	if bullet.is_in_group("Bullet"):
##		bullet.queue_free()
#		var bullet_index = bullet_array.find(bullet)
##		bullet.paused = true
#		bullet_paused_array.append(bullet_array.pop_at(bullet_index))
#		print("bullet_paused_array", bullet_paused_array)
#
#		print("exited")
#
#func _on_Area_area_entered(area: Area) -> void:
##	var player = area.get_parent()
##	if player.is_class("KinematicBody"):
##		shoot_timer.start()
#	pass

#
#func _on_Area_area_exited(area: Area) -> void:
#	var bullet = area.get_parent()
#	#this should probably use node name instead of class
#	if bullet.is_class("Sprite3D"):
##		bullet.queue_free()
#		var bullet_index = bullet_array.find(bullet)
##		bullet.paused = true
#		bullet_paused_array.append(bullet_array.pop_at(bullet_index))
#		print("bullet_paused_array", bullet_paused_array)
##
#		print("exited")
#	else:
#		print(bullet.get_class())
