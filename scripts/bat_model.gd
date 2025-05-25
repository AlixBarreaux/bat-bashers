extends Node3D
class_name BatModel


@onready var animation_tree: AnimationTree = %AnimationTree
@onready var hurt_sound: AudioStreamPlayer3D = %HurtSound



func hurt() -> void:
	animation_tree.set("parameters/OneShot/request", true)
	hurt_sound.play()
