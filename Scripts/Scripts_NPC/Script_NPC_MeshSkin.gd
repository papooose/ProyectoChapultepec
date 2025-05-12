extends Node
class_name NPC_MeshSkin


@export var material:ShaderMaterial
@export var target_mesh:MeshInstance3D
@export var skins_meshes:Array[ArrayMesh]


@export var ghost_spawner: sfx_ghostSpawner


func _switch_mesh(skin_index:int)->void:
	var last_material:Material = target_mesh.mesh.surface_get_material(0)
	target_mesh.mesh = skins_meshes[skin_index]
	target_mesh.mesh.surface_set_material(0,last_material)
