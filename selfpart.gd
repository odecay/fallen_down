extends Spatial

onready var attractor = $Attractor setget set_attractor, get_attractor

func set_attractor(_input):
	pass
func get_attractor() -> Node:
	return attractor
