extends RigidBody3D
class_name Enemy


@export var speed: float = randf_range(1.0, 2.0)

@onready var bat_model: BatModel = %BatModel
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var collision_shape_3d_radius: float = collision_shape_3d.shape.radius

@onready var player: Player = get_tree().get_nodes_in_group("Player")[0]

@export var health: int = 3
@onready var hurt_box: HurtBox = $HurtBox
@onready var hurt_box_collision_shape_3d: CollisionShape3D = hurt_box.get_node("CollisionShape3D")
@onready var deletion_timer: Timer = %DeletionTimer


func take_damage() -> void:
	if health == 0:
		return
	
	self.health -= 1
	
	if health > 0:
		bat_model.hurt()
	elif health <= 0:
		# Could replace hurt animation by a death one
		bat_model.hurt()
		self.set_physics_process(false)
		self.set_gravity_scale(1.0)
		#-1.0 -> Away from the player
		var direction: Vector3 = -1.0 * self.get_global_position().direction_to(player.get_global_position())
		var random_upward_force: Vector3 = Vector3.UP * randf_range(1.0, 5.0)
		apply_central_impulse(direction * 10.0 + random_upward_force)
		deletion_timer.start()
		GameStats.increase_score(1)


func _physics_process(_delta: float) -> void:
	var direction: Vector3 = self.get_global_position().direction_to(player.get_global_position())
	direction.y = 0.0
	self.linear_velocity =  direction * self.speed
	bat_model.look_at(player.global_position)
	
	if self.global_position.distance_to(player.global_position) <= collision_shape_3d_radius + 0.5:
		self.linear_velocity = Vector3.ZERO


func _on_timer_timeout() -> void:
	self.queue_free()
