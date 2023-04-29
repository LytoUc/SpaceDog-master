extends Node3D

@onready var path_follow = get_parent()
var SPEED = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("cam_left"):
		path_follow.progress -= delta*SPEED
	elif Input.is_action_pressed("cam_right"):
		path_follow.progress += delta*SPEED
