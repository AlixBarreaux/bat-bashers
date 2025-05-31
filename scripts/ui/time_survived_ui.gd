extends Label
class_name TimeSurvivedUI


func on_game_started() -> void:
	self.set_process(true)


func on_game_over() -> void:
	self.set_process(false)


func _ready() -> void:
	self.set_physics_process(false)
	Events.game_started.connect(on_game_started)
	Events.game_over.connect(on_game_over)


var time_survived: float = 0.0

func _process(delta: float) -> void:
	self.time_survived += delta
	self.set_text("Time survived: " + str("%0.2f" % self.time_survived))
