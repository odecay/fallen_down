extends Spatial

const chunk = preload("res://Assets/tower_tube.tscn")
const self_part = preload("res://selfpart.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var world = []
var counter = 0
var chunk_height = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	add_chunk()
	add_chunk()
	add_chunk()

func add_chunk():
	var new_chunk = chunk.instance()
	new_chunk.transform = new_chunk.transform.translated(Vector3(0,-200*counter,0))
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
	#old_chunk.transform = old_chunk.transform.translated(Vector3(0,-chunk_height*counter,0))
	#world.push_front(old_chunk)	
	old_chunk.queue_free()
	print(world)
	
func _on_LoadTrigger_body_exited(body):
	if body.name == "player":
		var size = world.size()
		add_chunk()
		if size > 3:
			remove_chunk()
		#$player.slow()
		#print(world)
		#$player.particle_stream()

func _on_SlowTrigger_body_entered(body):
	if body.name == "player":
		$player.particle_stream()
		$player.slow()
		if $player.has_orbs():
			var orb_position = $player.get_last_orb_position()
			var orb = $player.orb_remove()
			add_child(orb)
			orb.set_transform(orb_position)


func _on_SpeedTrigger_body_entered(body):
	if body.name == "player":
		#$player.particle_stream()
		#$player.boost()
		#var new_self_part = self_part.instance()
		#add_child(new_self_part)
		pass
