extends Label
class_name ScoreUI


func on_game_stats_score_set(value: int) -> void:
	self.set_text("Score: " + str(value))


func _ready() -> void:
	GameStats.score_set.connect(on_game_stats_score_set)
