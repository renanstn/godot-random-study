extends KinematicBody2D


enum State {
	IDLE,
	SEARCH_AND_DESTROY,
	DYING
}

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
			# TODO: Change status icon
			print("Idle state")
		State.SEARCH_AND_DESTROY:
			# TODO: Change status icon
			print("Search and destroy")
		State.DYING:
			print("Goodbye world...")


func _on_VisionArea_body_entered(body):
	set_state(State.SEARCH_AND_DESTROY)


func _on_VisionArea_body_exited(body):
	set_state(State.IDLE)
