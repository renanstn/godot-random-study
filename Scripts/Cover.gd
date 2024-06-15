extends Sprite


onready var collision_shape = $StaticBody2D/CollisionShape2D
onready var left_side = $CoverPositionLeft
onready var right_side = $CoverPositionRight
var being_used = false


func used():
	being_used = true
#	collision_shape.disabled = false


func unused():
	being_used = false
#	collision_shape.disabled = true


func _on_CoverArea_body_entered(body):
	if body is KinematicBody2D:
		body.can_take_cover = true
		body.cover_object = self


func _on_CoverArea_body_exited(body):
	if body is KinematicBody2D:
		unused()
		body.can_take_cover = false
		body.cover_object = null
