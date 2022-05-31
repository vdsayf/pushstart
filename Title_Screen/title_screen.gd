extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var scene_path_to_load
# Called when the node enters the scene tree for the first time.
func _ready():
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$fadeRect.show()
	$fadeRect.fade_In()


func _on_fadeRect_fade_finished():
	get_tree().change_scene(scene_path_to_load)
	#when scene actually loads
