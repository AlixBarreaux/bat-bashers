extends Node


func _ready() -> void:
	TranslationServer.set_locale(OS.get_locale())
