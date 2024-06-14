extends KinematicBody2D


const UP: Vector2 = Vector2(0, -1)
const GRAVITY: int = 15
const JUMP: int = 300
export var speed: int = 100

onready var sprite = $Sprite
onready var animator = $AnimationPlayer
onready var raycast = $RayCast2D
onready var shoot_sound = $ShootSound

var explosion_scene = preload("res://Scenes/Explosion.tscn")
var motion = Vector2()
var looking_to_right = true
var can_move = true
var can_take_cover = false  # Controlled by Cover scene
var cover_object = null     # Controlled by Cover scene
var covered = false
var can_shoot = true


func _physics_process(_delta):
	motion.y += GRAVITY
	if can_move:
		motion = move_and_slide(fromInputsToMotion(), UP)
	checkActionsInput()
	animate()


func fromInputsToMotion() -> Vector2:
	if Input.is_action_pressed("ui_right"):
		motion.x = speed
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed
	else:
		motion.x = 0
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		motion.y = -JUMP
	return motion


func checkActionsInput():
	if Input.is_action_just_pressed("ui_down"):
		take_cover()
	if Input.is_action_just_released("ui_down"):
		out_cover()
	if Input.is_action_just_pressed("ui_accept"):
		shoot()


func animate():
	if motion.x != 0:
		animator.play("Walking")
	else:
		animator.play("Idle")
	if !is_on_floor():
		animator.play("Jumping")
	# Flip sprite when change direction
	if motion.x > 0 and not looking_to_right:
		looking_to_right = true
		scale.x = -1
	elif motion.x < 0 and looking_to_right:
		looking_to_right = false
		scale.x = -1
	if covered:
		animator.play("Blink")


func take_cover():
	if can_take_cover:
		covered = true
		can_move = false
		sprite.modulate.r = 0.4
		sprite.modulate.g = 0.4
		sprite.modulate.b = 0.4
		cover_object.used()
		if global_position.x < cover_object.global_position.x:
			position.x = cover_object.left_side.global_position.x
		else:
			position.x = cover_object.right_side.global_position.x


func out_cover():
	covered = false
	can_move = true
	sprite.modulate.r = 1
	sprite.modulate.g = 1
	sprite.modulate.b = 1
	cover_object.unused()


func shoot():
	if not can_shoot:
		return
	shoot_sound.play()
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		var collision_point = raycast.get_collision_point()
		var explosion_instance = explosion_scene.instance()
		explosion_instance.position = collision_point
		get_parent().add_child(explosion_instance)
