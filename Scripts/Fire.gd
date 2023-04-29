extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fire():
	if Input.is_action_just_pressed("space") and $Timer.time_left == 0:
		$Timer.start()
		$AnimationPlayer.play("push")
		$GPUParticles2D.emitting = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fire()
	$ProgressBar.value = 3 - $Timer.time_left
