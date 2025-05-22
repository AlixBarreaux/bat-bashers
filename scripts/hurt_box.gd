extends Area3D
class_name HurtBox


@export var entity_receiving_damage: Node = null


func enable() -> void:
	for collision_shape: CollisionShape3D in self.get_children():
		collision_shape.set_deferred("disabled", false)


func disable() -> void:
	for collision_shape: CollisionShape3D in self.get_children():
		collision_shape.set_deferred("disabled", true)


func _ready() -> void:
	assert(entity_receiving_damage != null)


func receive_hitbox_info() -> void:
	entity_receiving_damage.take_damage()
