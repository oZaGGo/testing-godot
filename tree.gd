extends StaticBody2D

func _process(delta: float):
	$AnimationPlayer.speed_scale = 1
	$AnimationPlayer.play("wind")
