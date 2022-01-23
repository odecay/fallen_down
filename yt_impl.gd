extends Node

const SPEED := 10.0

onready var multi_mesh_instance : MultiMeshInstance = $MultiMeshInstance
onready var multi_mesh : MultiMesh = multi_mesh_instance.multimesh

var array : Array

func createShoot(at_position : Vector3, basis : Basis):
	var bullet : RID = PhysicsServer.area_create()
	var xform := Transform()
	xform.origin = at_position
	xform.basis = basis
	var shape = PhysicsServer.shape_create(PhysicsServer.SHAPE_SPHERE)
	PhysicsServer.shape_set_data(shape,1.5)

	var array_data : Dictionary = {"rid":bullet,"xform":xform}
	var script = load("res://data/enemies/BulletScript.gd").new(self,array_data)
	array_data.script = script
	PhysicsServer.area_set_monitor_callback(bullet,script,"remove")

	PhysicsServer.area_set_collision_layer(bullet,0b1000) # specific to my needs
	PhysicsServer.area_set_collision_mask(bullet,0b110010) #  specific to my needs
	PhysicsServer.area_set_transform(bullet,xform)
	PhysicsServer.area_add_shape(bullet,shape)
	PhysicsServer.area_set_space(bullet,multi_mesh_instance.get_world().space)

	array.append(array_data)
	
func _physics_process(delta: float) -> void:
	multi_mesh.instance_count = array.size()
	var idx : int = 0
	for i in array:
		i.xform.origin = i.xform.origin-(i.xform.basis.z*delta*SPEED)
		PhysicsServer.area_set_transform(i.rid,i.xform)
		multi_mesh.set_instance_transform(idx,i.xform)
		idx += 1

func removeByDictionary(dic : Dictionary):
	PhysicsServer.free_rid(dic.rid)
	array.erase(dic)


#Workaround BulletScript.gd for collision:
#extends Reference

var dic : Dictionary
var bullets_manager

func _init(p_bullets_manager, p_dic : Dictionary) -> void:
	dic = p_dic
	dic.script = self
	bullets_manager = p_bullets_manager

func remove(exited_body : bool,collider_rid : RID, collider_instance : int, collider_shape : int, area_shape : int):
	bullets_manager.removeByDictionary(dic)
