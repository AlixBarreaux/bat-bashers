extends RigidBody3D
class_name Mob


@onready var bat_model: BatModel = %BatModel


func take_damage() -> void:
	bat_model.hurt()
