extends KinematicBody2D


enum State {
	IDLE,
	SEARCH_AND_DESTROY,
	DYING
}

onready var state_indicator = $StateIndicator/AnimationPlayer

var energy = 1
var current_state = State.IDLE


func _ready():
	pass


func _process(delta):
	pass


func set_state(new_state):
	current_state = new_state
	match current_state:
		State.IDLE:
			state_indicator.play("Idle")
			print("Idle state")
		State.SEARCH_AND_DESTROY:
			state_indicator.play("Angry")
			print("Search and destroy")
		State.DYING:
			print("Goodbye world...")


func _on_VisionArea_body_entered(body):
	if body != self and body is KinematicBody2D:
		set_state(State.SEARCH_AND_DESTROY)


func _on_VisionArea_body_exited(body):
	if body != self and body is KinematicBody2D:
		set_state(State.IDLE)
