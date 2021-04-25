extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var trigger = $LoadTrigger setget set_trigger, get_trigger
onready var slow_trigger = get_node("Sprite3D/SlowTrigger") setget set_slow_trigger, get_slow_trigger
onready var speed_trigger = get_node("Sprite3D2/SpeedTrigger") setget set_speed_trigger, get_speed_trigger
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_trigger(input):
	pass
func get_trigger():
	return trigger

func set_slow_trigger(input):
	pass
func get_slow_trigger():
	return slow_trigger

func set_speed_trigger(input):
	pass
func get_speed_trigger():
	return speed_trigger
