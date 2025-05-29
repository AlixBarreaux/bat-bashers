extends Node
# class_name GameStats

var score: int = 0

signal score_set(value: int)


func on_game_started() -> void:
	self.reset_score()


func set_score(value: int) -> void:
	self.score = value
	self.score_set.emit(value)


func increase_score(value: int = 1) -> void:
	self.set_score(score + value) 


func reset_score() -> void:
	self.set_score(0)


func _ready() -> void:
	Events.game_started.connect(on_game_started)
