extends KinematicBody2D

var target

onready var tween = get_node("Tween")

func get_input():
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		target = get_global_mouse_position()
		tween.interpolate_property(self, "position", position, target, target.distance_to(position)/600, Tween.TRANS_EXPO, Tween.EASE_OUT)
		tween.start()
	

func _physics_process(delta):
	get_input()
	
	# rotation = velocity.angle()
	#if (target - position).length() > 5:
		#velocity = move_and_slide(velocity)




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
