extends Sprite


onready var animator = $AnimationPlayer


func _ready():
	animator.play("Explode")


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
