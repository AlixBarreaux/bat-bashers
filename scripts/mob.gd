extends RigidBody3D
class_name Mob


@export var speed: float = randf_range(1.0, 2.0)

@onready var bat_model: BatModel = %BatModel
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var collision_shape_3d_radius: float = collision_shape_3d.shape.radius

@onready var player: Player = get_tree().get_nodes_in_group("Player")[0]


func take_damage() -> void:
	bat_model.hurt()


func _physics_process(_delta: float) -> void:
	var direction: Vector3 = self.get_global_position().direction_to(player.get_global_position())
	direction.y = 0.0
	self.linear_velocity =  direction * self.speed
	bat_model.look_at(player.global_position)
	
	if self.global_position.distance_to(player.global_position) <= collision_shape_3d_radius + 0.5:
		self.linear_velocity = Vector3.ZERO
