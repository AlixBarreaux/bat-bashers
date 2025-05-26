extends Area3D
class_name HitBox


# If set to 0, insta kill the entity
@export var damage_value: int = 0

func enable() -> void:
	for collision_shape: CollisionShape3D in self.get_children():
		collision_shape.set_disabled(false)


func disable() -> void:
	for collision_shape: CollisionShape3D in self.get_children():
		collision_shape.set_disabled(true)


func _on_area_entered(area: HurtBox) -> void:
	area.receive_hitbox_info(damage_value)
