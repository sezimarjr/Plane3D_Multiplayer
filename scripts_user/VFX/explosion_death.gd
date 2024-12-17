extends Node3D

@onready var smoke: GPUParticles3D = $smoke
@onready var fire: GPUParticles3D = $fire
@onready var debris: GPUParticles3D = $debris
@onready var spot_light_3d: SpotLight3D = $SpotLight3D

func _ready() -> void:
	smoke.emitting = true
	fire.emitting = true
	debris.emitting = true
	var tween = create_tween()
	tween.tween_property(spot_light_3d,"light_energy",0.0,2.0)
	await smoke.finished
	queue_free()
	
