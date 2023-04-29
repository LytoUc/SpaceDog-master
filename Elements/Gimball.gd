extends Node3D
var invert_y = false
var invert_x = false
var mouse_control = true
var mouse_sensitivity = 0.1

var max_zoom = 3.0
var min_zoom = 0.5
var zoom_speed = 0.09

var zoom = 1.5

@export var target : NodePath


var rotation_speed = PI/2

@onready var inner = $InnerGimball
func _unhandled_input(event):
	if event.is_action_pressed("cam_zoom_in"):
		zoom -= zoom_speed
	if event.is_action_pressed("cam_zoom_up"):
		zoom += zoom_speed
	zoom = clamp(zoom, min_zoom, max_zoom)

func get_input_keyboard(delta):
	# Rotate outer gimbal around y axis
	var y_rotation = 0
	if Input.is_action_pressed("cam_right"):
		y_rotation += 1
	if Input.is_action_pressed("cam_left"):
		y_rotation += -1
	global_rotate(Vector3.UP, y_rotation * rotation_speed * delta)
	# Rotate inner gimbal around local x axis
	var x_rotation = 0
	if Input.is_action_pressed("cam_up"):
		x_rotation += -1
	if Input.is_action_pressed("cam_down"):
		x_rotation += 1
	inner.global_rotate(Vector3.RIGHT, x_rotation * rotation_speed * delta)

func _process(delta):
	scale = lerp(scale, Vector3.ONE * zoom, zoom_speed)
	get_input_keyboard(delta)
	inner.rotation.x = clamp(inner.rotation.x, -1.4, -0.01)
	if target:
		global_transform.origin = get_node(target).global_transform.origin
	
