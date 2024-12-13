extends MeshInstance3D


func _ready() -> void:
	pass 


func _process(_delta: float) -> void:
	pass


func _on_static_body_3d_body_entered(body: Node3D) -> void:
	print(body)
