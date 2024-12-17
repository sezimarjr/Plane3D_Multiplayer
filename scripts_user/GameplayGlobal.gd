extends Node

const VFX_EXPOSION = preload("res://vfx/vfx_exposion.tscn")

var vfx_node : Node3D


func countdown_to_method(_container_to_inst , _method : Callable , _duration : float) -> void:
	var timer : Timer = Timer.new()
	_container_to_inst.add_child(timer)
	timer.timeout.connect(_method)
	timer.timeout.connect(timer.queue_free)
	timer.wait_time = _duration
	timer.one_shot = true
	timer.start()


func on_off_all_collisions(_array : Array , _disabled : bool = true) -> void:
	for collision in _array:
		if collision is CollisionShape3D:  
			collision.disabled = _disabled
		elif collision is CollisionPolygon3D:  
			collision.set_disabled(_disabled)
		else:
			print("Elemento no array não é uma forma de colisão 3D:", collision)


func vfx_small_explosion(_g_position : Vector3 , _container = GameplayGlobal.vfx_node) -> void:
	var _explosion := VFX_EXPOSION.instantiate()
	if is_instance_valid(GameplayGlobal.vfx_node):
		_container.add_child(_explosion)
	if !is_instance_valid(GameplayGlobal.vfx_node):
		get_parent().add_child(_explosion)
	_explosion.global_position = _g_position
		
	
func map_range(value, value_min, value_max, to_min, to_max):
	return (value - value_min) * (to_max - to_min) / (value_max - value_min) + to_min


func get_random_color() -> Color:
	var r = randf()
	var g = randf()
	var b = randf()
	return Color(r, g, b)
