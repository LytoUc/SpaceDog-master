extends Area2D

var entered = false
@export var loaded_level :PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered:
		get_tree().change_scene_to_packed(loaded_level)


func _on_body_entered(body :RigidBody2D):
	entered = true


func _on_body_exited(body :RigidBody2D):
	entered = false
