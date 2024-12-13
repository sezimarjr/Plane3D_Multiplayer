extends Marker3D

@onready var second_turn_left: Marker3D = $"../second_turn_left"
@onready var second_turn_right: Marker3D = $"../second_turn_right"

const SMOOTH = 0.01
@onready var default_pos : Vector3 = position


func _process(_delta: float) -> void:
	
	if Input.is_action_pressed("move_left"):
		position = lerp(position,second_turn_right.position,SMOOTH)
	if Input.is_action_pressed("move_right"):
		position = lerp(position,second_turn_left.position,SMOOTH)
		
	if !Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right"):
		position = lerp(position,default_pos,SMOOTH * 2)
