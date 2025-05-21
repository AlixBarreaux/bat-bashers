extends Node3D
class_name Gun


@export var projectile_scene: PackedScene = load("res://scenes/projectile.tscn")

@onready var marker_3d: Marker3D = %Marker3D
@onready var shoot_cooldown_timer: Timer = %ShootCooldownTimer


func shoot() -> void:
	shoot_cooldown_timer.start()
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.set_global_transform(marker_3d.get_global_transform())
	get_tree().get_root().add_child(projectile)


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and shoot_cooldown_timer.is_stopped():
		self.shoot()
