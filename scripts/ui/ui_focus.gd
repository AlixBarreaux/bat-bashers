extends Node
class_name UIFocus


@export var parent_node: Control = null
@export var element_to_focus: Control = null

func set_element_to_focus(element: Control) -> void:
	self.element_to_focus = element


func on_parent_node_visibility_changed() -> void:
	if element_to_focus.is_visible():
		element_to_focus.grab_focus()


func on_viewport_gui_focus_changed(control: Control) -> void:
	if control.get_owner() == self.parent_node:
		if self.parent_node.is_visible():
			self.set_element_to_focus(control)


func _ready() -> void:
	assert(parent_node != null)
	assert(parent_node is Control)
	assert(element_to_focus != null)
	
	parent_node.visibility_changed.connect(on_parent_node_visibility_changed)
	get_viewport().gui_focus_changed.connect(on_viewport_gui_focus_changed)
