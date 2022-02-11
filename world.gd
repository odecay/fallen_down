extends Spatial

const chunk = preload("res://Assets/tower_tube.tscn")
const platform = preload("res://Assets/hex_tile.tscn")
const self_part = preload("res://selfpart.tscn")

var world = []
var past = []
var counter = 0
var chunk_height = 200
var world_hex_orbs = []

func _ready():
	add_chunk()
	add_chunk()
	add_chunk()
	add_chunk()
	add_chunk()
	add_chunk()

func add_chunk():
	var new_chunk = chunk.instance()
	new_chunk.transform = new_chunk.transform.translated(Vector3(0,-chunk_height*counter,0))
	add_child(new_chunk)
	var trigger = new_chunk.get_trigger()
	var slow_trigger = new_chunk.get_slow_trigger()
	var speed_trigger = new_chunk.get_speed_trigger()
	trigger.connect("body_entered",self, "_on_LoadTrigger_body_entered")
	slow_trigger.connect("body_entered",self,"_on_SlowTrigger_body_entered")
	speed_trigger.connect("body_entered",self,"_on_SpeedTrigger_body_entered")
	world.push_front(new_chunk)
	counter += 1
	
func pass_chunk():
	var old_chunk = world.pop_back()
	past.push_front(old_chunk)

func move_chunk():
	var new_old_chunk = past.pop_back()
	new_old_chunk.translation = Vector3(0,-chunk_height*counter,0)
	world.push_front(new_old_chunk)
	counter += 1

	
func _on_LoadTrigger_body_entered(body):
	if body.name == "player":
		pass_chunk()
		if past.size() > world.size():
			move_chunk()

#		if world.size() < 4:
#			add_chunk()
		
		#if counter % 3 == 0:
		#	var node = platform.instance()
		#	node.transform = node.transform.translated(Vector3(0,-chunk_height*counter,0))
		#	add_child(node)



func _on_SlowTrigger_body_entered(body):
	if body.name == "player":
		$player.particle_stream()
		$player.slow()
		if $player.has_orbs():
			var orb_position = $player.get_last_orb_position()
			var orb = $player.orb_remove()
			add_child(orb)
			orb.set_transform(orb_position)
			world_hex_orbs.append(orb)


func _on_SpeedTrigger_body_entered(body):
	if body.name == "player":
		if $player.has_orbs():
			$player.particle_stream()
			$player.boost()
		#var new_self_part = self_part.instance()
		#$player.add_child(new_self_part)
		#var orb_position = $player.global_transform
		#new_self_part.set_transform(orb_position)
		#$player.orb_add(new_self_part)
		#pass
