extends Sprite


func _on_CoverArea_body_entered(body):
	if body is KinematicBody2D:
		body.can_take_cover = true

func _on_CoverArea_body_exited(body):
	if body is KinematicBody2D:
		body.can_take_cover = false
