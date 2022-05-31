extends Node2D

export (int) var speed = 200
var target = Vector2()
var velocity = Vector2()

func get_input():
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		target = get_global_mouse_position()

func _process(delta):
	velocity = (target-position).normalized() * speed
	
	position += velocity*speed
		
	
	

