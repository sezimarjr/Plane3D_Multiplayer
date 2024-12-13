extends Node3D

@export var players_container: Node3D 
@export var planes : PackedScene

func _ready() -> void:
	
	if !multiplayer.is_server():
		return
		

func _process(_delta: float) -> void:
	pass
