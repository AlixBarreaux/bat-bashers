extends CharacterBody3D
class_name Player


@export var camera_sensitivity: float = 0.07
var camera_rotation_limit_x_min: float = -80.0
var camera_rotation_limit_x_max: float = 80.0

@export var speed: float = 5.5

@onready var camera_3d: Camera3D = %Camera3D


func _physics_process(delta: float) -> void:
	var input_direction_2d: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var input_direction_3d: Vector3 = Vector3(input_direction_2d.x, 0.0, input_direction_2d.y)
	
	var direction: Vector3 = self.get_transform().basis * input_direction_3d
	
	self.velocity.x = direction.x * self.speed
	self.velocity.z = direction.z * self.speed
	
	self.velocity.y -= 20.0 * delta
	if Input.is_action_just_pressed("jump") and self.is_on_floor():
		self.velocity.y = 10.0
	elif Input.is_action_just_released("jump") and self.velocity.y > 0.0:
		self.velocity.y = 0.0
	
	self.move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		self.rotation_degrees.y -= event.get_screen_relative().x * self.camera_sensitivity
		self.camera_3d.rotation_degrees.x -= event.get_screen_relative().y * self.camera_sensitivity
		self.camera_3d.rotation_degrees.x = clamp(self.camera_3d.rotation_degrees.x, self.camera_rotation_limit_x_min, self.camera_rotation_limit_x_max)


func die() -> void:
	print(self.name, ": Die!")


@onready var health: Health = %Health

func _on_health_decreased(_value: int) -> void:
	# Could play animation when hurt
	pass


func _on_health_fully_depleted() -> void:
	self.die()
