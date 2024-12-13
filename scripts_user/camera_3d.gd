extends Camera3D

@onready var target_pos : Marker3D = $"../MainPlane/vfx_node_texture/node_texture/cameras/second_person"
@export var distance = 5.0


func _process(_delta: float) -> void:
	
	var target_owner = target_pos.owner as CharacterBody3D
	if not target_owner:
		return

	var target_position = target_owner.global_position
	
	
	global_position = target_pos.global_position


	look_at(target_position, Vector3.UP) 
