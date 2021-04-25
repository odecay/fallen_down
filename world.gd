extends Spatial

const chunk = preload("res://Assets/tower_tube.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var world = [Node.new(),Node.new(),Node.new()]
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_chunk()
	add_chunk()
	add_chunk()
	add_chunk()
	add_chunk()
	add_chunk()
	add_chunk()

func add_chunk():
	var new_chunk = chunk.instance()
	new_chunk.transform = new_chunk.transform.translated(Vector3(0,-100*counter,0))
	add_child(new_chunk)
	var trigger = new_chunk.get_trigger()
	var slow_trigger = new_chunk.get_slow_trigger()
	var speed_trigger = new_chunk.get_speed_trigger()
	trigger.connect("body_exited",self, "_on_LoadTrigger_body_exited")
	slow_trigger.connect("body_entered",self,"_on_SlowTrigger_body_entered")
	speed_trigger.connect("body_entered",self,"_on_SpeedTrigger_body_entered")
	world.push_front(new_chunk)
	counter += 1
	
func remove_chunk():

	var old_chunk = world.pop_back()	
	old_chunk.queue_free()
	
func _on_LoadTrigger_body_exited(body):
	if body.name == "player":
		add_chunk()
		remove_chunk()
		#$player.slow()
		#print(world)
		#$player.particle_stream()

func _on_SlowTrigger_body_entered(body):
	if body.name == "player":
		$player.particle_stream()
		$player.slow()


func _on_SpeedTrigger_body_entered(body):
	if body.name == "player":
		#$player.particle_stream()
		#$player.boost()
		pass
