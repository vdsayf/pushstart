extends KinematicBody2D

export (PackedScene) var cardSim
enum cardType {push, number, reverse}
enum color {red, yellow, blue, green, purple}
var tipe = cardType.number
var valyu
var colo

onready var tween = get_node("Tween")

func _setType(typ):
	tipe = typ
	if tipe == cardType.push:
		$bombreverseback.set_frame_color(Color(1,1,1,1))
		$bombreverseback/bombreverselabel.set_text(str("BOMB"))
		$bombreverseback/bombreverselabel.set("custom_colors/font_color", Color(1,0,0,1))
	elif tipe == cardType.reverse:
		$bombreverseback.set_frame_color(Color(1,1,1,1))
		$bombreverseback/bombreverselabel.set_text(str("RVRSE"))
		$bombreverseback/bombreverselabel.set("custom_colors/font_color", Color(0.75,0.75,0.75,1))
	
func _setNumb(typ, num, col):
	tipe = typ
	valyu = num
	colo = col
	$topLabel.set_text(str(valyu))
	$centerLabel.set_text(str(valyu))
	if colo == "red": #red
		$cardBody.set_frame_color(Color(0.8,0,0,1))
	elif colo == "purple": #purple
		$cardBody.set_frame_color(Color(0.5,0,0.5,1))
	elif colo == "blue": #blue
		$cardBody.set_frame_color(Color(0,0.3,0.8,1))
	elif colo == "yellow": #yellow
		$cardBody.set_frame_color(Color(0.8,0.8,0,1))
	elif colo == "green": #green
		$cardBody.set_frame_color(Color(0.2,0.7,0.2,1))
		
	
func _ready():
	hide()

#animate move card to target
func _moveTo(target):
	tween.interpolate_property(self, "position", position, target, 1, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.start()
