extends Node
class_name Health


# If left to 0, will be invincible
@export var max_health: int = 0
@export var health: int = 0


signal changed(value: int)
signal increased(value: int)
signal decreased(value: int)
signal fully_depleted()


func _ready() -> void:
	if health <= 0:
		set_health(max_health)


func set_health(value: int) -> void:
	health = value
	self.changed.emit(value)


func increase_health(value: int) -> void:
	self.set_health(health + value)
	self.increased.emit(value)


func decrease_health(value: int) -> void:
	self.set_health(health - value)
	self.decreased.emit(value)


func replenish_all_health() -> void:
	self.set_health(self.max_health)
	self.increased.emit(self.max_health)


func deplete_all_health() -> void:
	self.set_health(0)
	self.decreased.emit(0)


func take_damage(damage_value: int) -> void:
	if health == 0:
		return
	
	# 0 = insta kill
	if damage_value == 0:
		self.deplete_all_health()
	else:
		self.decrease_health(damage_value)
	
	if health <= 0:
		self.fully_depleted.emit()
