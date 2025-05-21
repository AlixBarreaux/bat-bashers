extends Node3D
class_name Projectile


const SPEED: float = 100.0
# When it goes over this distance limit, it's queue_freed
const DELETION_RANGE: float = 100.0


var traveled_distance: float = 0.0

func _physics_process(delta: float) -> void:
	self.global_position += -transform.basis.z * SPEED * delta
	traveled_distance += SPEED * delta
	
	if traveled_distance > DELETION_RANGE:
		self.queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Mob:
		body.take_damage()
	self.queue_free()
