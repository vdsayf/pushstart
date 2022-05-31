extends ColorRect

signal fade_finished

func fade_In():
	$AnimationPlayer.play("fade_In")
	

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("fade_finished") # Replace with function body.
