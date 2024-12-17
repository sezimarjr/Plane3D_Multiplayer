extends CharacterBody3D
class_name SHOT_CharacterBody3D

@onready var hitbox_collision: CollisionShape3D = $hitbox/collision
@onready var collision: CollisionShape3D = $collision

const SPEED : float = 160.0 
const ACCELERATION : float = 3.0
var direction : Vector3
var life_time : float = 8.0


func _physics_process(_delta: float) -> void:
	
	velocity = -transform.basis.z * SPEED
	move_and_slide()
	if is_on_ceiling() or is_on_floor() or is_on_floor():
		go_to_death()


func _ready() -> void:
	
	GameplayGlobal.countdown_to_method(self,go_to_death,life_time)
	var _callable = Callable(GameplayGlobal, "on_off_all_collisions").bind([hitbox_collision, collision], false)
	GameplayGlobal.countdown_to_method(self,_callable,0.1)
	direction = transform.basis.z
	visible = true
	direction = -transform.basis.z
	velocity = direction * SPEED
	
	
func go_to_death() -> void:
	GameplayGlobal.call_deferred("on_off_all_collisions", [hitbox_collision, collision], true)
	GameplayGlobal.call_deferred("vfx_small_explosion", global_position)
	queue_free()	
	
	
func _on_hitbox_body_entered(_body: Node3D) -> void:
	go_to_death()
