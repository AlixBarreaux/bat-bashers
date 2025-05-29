extends Button
class_name ChangeSceneButton


@export_file("*.scn", "*.tscn") var scene_to_load_path: String = ""
@export var packed_scene_to_load: PackedScene = null


func _ready() -> void:
	assert(FileAccess.file_exists(self.scene_to_load_path) or self.packed_scene_to_load != null)


func _on_pressed() -> void:
	var error: Error = FAILED
	
	if self.scene_to_load_path != "":
		error = get_tree().change_scene_to_file(self.scene_to_load_path)
	else:
		error = get_tree().change_scene_to_packed(self.packed_scene_to_load)
	
	if error != OK:
		printerr("(!) ERROR: Unable to load scene in ", self.get_name())
