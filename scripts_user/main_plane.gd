extends CharacterBody3D

@export var player_id := 1:
	set(id):
		player_id = id
@export var input_dir : Vector2 = Vector2.ZERO
var mesh_color : Color

const SPEED : float = 90.0 
const ACCELERATION : float = 3.0
var direction : Vector3 = Vector3.ZERO

const TURN_ACCELERATION : float = 0.04
const TURN_MAX_SPEED_X : float = 2.0
const TURN_MAX_SPEED_Y : float = 2.0
var turn_speed_x : float = 0.0
var turn_speed_y : float = 0.0

@onready var vfx_node_texture: Node3D = $vfx_node_texture
@onready var node_texture: Node3D = $vfx_node_texture/node_texture
@onready var plane_mesh: Node3D = $vfx_node_texture/node_texture/plane_mesh
@onready var planeMesh: MeshInstance3D = $vfx_node_texture/node_texture/plane_mesh/Plane
@onready var minigun_mesh1: MeshInstance3D = $vfx_node_texture/node_texture/plane_mesh/Plane/minigun1
@onready var minigun_mesh2: MeshInstance3D = $vfx_node_texture/node_texture/plane_mesh/Plane/minigun2
@onready var second_person: Marker3D = $vfx_node_texture/node_texture/cameras/second_person

@onready var cam: Camera3D = $vfx_node_texture/node_texture/cameras/Camera3D

@onready var mesh_instance = MeshInstance3D

@onready var shotmarker1: Marker3D = $vfx_node_texture/node_texture/plane_mesh/Plane/shot1
@onready var shotmarker2: Marker3D = $vfx_node_texture/node_texture/plane_mesh/Plane/shot2

	
func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
	
	
@rpc
func sync_color(new_color: Color):
	set_plane_color(new_color)
	
	
func _ready() -> void:
	cam.current = is_multiplayer_authority()
	if is_multiplayer_authority():
		var random_color = GameplayGlobal.get_random_color()
		set_plane_color(random_color)
		rpc("sync_color",random_color)
		
		
	
	
		
	
		
	
		
func set_plane_color(new_color:Color):
	mesh_color = new_color
	var material = StandardMaterial3D.new()
	material.albedo_color = mesh_color
	planeMesh.set_surface_override_material(0,material)
	minigun_mesh1.set_surface_override_material(0,material)
	minigun_mesh2.set_surface_override_material(0,material)
	
func _physics_process(_delta: float) -> void:
	
	forward_plane()
	move_and_slide()
	set_input_dir()
	rotation_xyz()
	animation_roll()



	



func forward_plane() -> void:
	if Input.is_action_just_pressed("action"):
		shot_minigun(shotmarker1.global_position , node_texture.transform.basis.z)
		shot_minigun(shotmarker2.global_position , node_texture.transform.basis.z)
	direction = -node_texture.transform.basis.z
	velocity = velocity.move_toward(direction * SPEED, ACCELERATION)
		
		
func rotation_xyz() -> void:
	if input_dir.x == 0:
		turn_speed_y = lerp(turn_speed_y,0.0,TURN_ACCELERATION)
	elif input_dir.x == 1:
		turn_speed_y = lerp(turn_speed_y,-TURN_MAX_SPEED_Y,TURN_ACCELERATION)
	elif input_dir.x == -1:
		turn_speed_y = lerp(turn_speed_y,TURN_MAX_SPEED_Y,TURN_ACCELERATION)	
	node_texture.rotation_degrees.y += turn_speed_y
	
	if input_dir.y == 0:
		turn_speed_x = lerp(turn_speed_x,0.0,TURN_ACCELERATION)
	elif input_dir.y == 1:
		turn_speed_x = lerp(turn_speed_x,-TURN_MAX_SPEED_X,TURN_ACCELERATION)
	elif input_dir.y == -1:
		turn_speed_x = lerp(turn_speed_x,TURN_MAX_SPEED_X,TURN_ACCELERATION)
	node_texture.rotation_degrees.x += turn_speed_x
	

func animation_roll() -> void:
	if is_multiplayer_authority():
		plane_mesh.rotation_degrees.z = clamp(plane_mesh.rotation_degrees.z,-90,90)
		plane_mesh.rotation_degrees.z = GameplayGlobal.map_range(turn_speed_y,-2.0,2.0,-90.0,90.0)
		

func set_input_dir() -> void:
	input_dir.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input_dir.y = int(Input.is_action_pressed("move_up")) - int(Input.is_action_pressed("move_down"))


func shot_minigun(_gp : Vector3 , _direction : Vector3) -> void:
	const SHOT_MINIGUN = preload("res://shots/shot_minigun.tscn")
	var _shot_minigun := SHOT_MINIGUN.instantiate()
	GameplayGlobal.vfx_node.add_child(_shot_minigun)
	_shot_minigun.global_position = _gp
	_shot_minigun.transform.basis.z = _direction
	
