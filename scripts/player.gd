extends CharacterBody3D
class_name Player


@export var camera_sensitivity: float = Settings.camera_sensitivity
var camera_rotation_limit_x_min: float = -80.0
var camera_rotation_limit_x_max: float = 80.0

@export var speed: float = 5.5

@onready var camera_3d: Camera3D = %Camera3D
@onready var health: Health = %Health

var knockback_velocity: Vector3 = Vector3.ZERO


func die() -> void:
	Events.game_over.emit()
	self.queue_free()


func _on_health_decreased(_value: int) -> void:
	pass


func _on_health_fully_depleted() -> void:
	self.die()


func on_camera_sensitivity_changed(value: float) -> void:
	self.camera_sensitivity = value


func knockback(from_position: Vector3) -> void:
	var strength: float = 15.0
	var vertical_strength: float = 10.0  # Adjust for arc height
	
	var knockback_direction: Vector3 = (self.get_global_position() - from_position).normalized()
	knockback_direction.y = 0.0
	knockback_direction = knockback_direction.normalized()
	
	knockback_velocity = knockback_direction * strength
	self.velocity.y = vertical_strength  # Apply arc lift here directly


func _on_hurt_box_hitbox_info_received(damage_value: int, damage_location: Vector3) -> void:
	self.knockback(damage_location)


func _ready() -> void:
	Settings.camera_sensitivity_changed.connect(on_camera_sensitivity_changed)


func _physics_process(delta: float) -> void:
	var input_direction_2d: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var input_direction_3d: Vector3 = Vector3(input_direction_2d.x, 0.0, input_direction_2d.y)
	var direction: Vector3 = self.get_transform().basis * input_direction_3d

	# Horizontal movement
	self.velocity.x = direction.x * self.speed + knockback_velocity.x
	self.velocity.z = direction.z * self.speed + knockback_velocity.z

	# Gravity
	self.velocity.y -= 20.0 * delta

	# Jump
	if Input.is_action_just_pressed("jump") and self.is_on_floor():
		self.velocity.y = 10.0
	elif Input.is_action_just_released("jump") and self.velocity.y > 0.0:
		self.velocity.y = 0.0

	# Decay knockback (horizontal only)
	knockback_velocity.x = lerp(knockback_velocity.x, 0.0, delta * 5.0)
	knockback_velocity.z = lerp(knockback_velocity.z, 0.0, delta * 5.0)

	self.move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self.rotation_degrees.y -= event.get_screen_relative().x * self.camera_sensitivity
		self.camera_3d.rotation_degrees.x -= event.get_screen_relative().y * self.camera_sensitivity
		self.camera_3d.rotation_degrees.x = clamp(
			self.camera_3d.rotation_degrees.x,
			self.camera_rotation_limit_x_min,
			self.camera_rotation_limit_x_max
		)
