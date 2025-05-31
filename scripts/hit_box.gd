extends Area3D
class_name HitBox


# If set to 0, insta kill the entity
@export var damage_value: int = 0
# Position of this node will be used to determine damage location (coming from)
@export var damage_location_subject: Node3D = null

func enable() -> void:
	for collision_shape: CollisionShape3D in self.get_children():
		collision_shape.set_disabled(false)


func disable() -> void:
	for collision_shape: CollisionShape3D in self.get_children():
		collision_shape.set_disabled(true)


func _ready() -> void:
	if not self.damage_location_subject:
		self.damage_location_subject = self


func _on_area_entered(area: HurtBox) -> void:
	area.receive_hitbox_info(self.damage_value, self.damage_location_subject.get_global_position())
