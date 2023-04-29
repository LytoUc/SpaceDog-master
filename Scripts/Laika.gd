extends RigidBody2D

var torque = 0.0

const SPEED = 70

func _ready():
	$AnimationPlayer.play("RESET")

func get_input():
	torque = 0.0
	if Input.is_action_pressed("down"):
		torque += 1.0
	if Input.is_action_pressed("up"):
		torque -= 1.0

func _physics_process(delta):
	get_input()
	apply_torque(torque*SPEED)
	#recordar timer de la interfaz!
	if Input.is_action_just_pressed("space"):
		var impulse_strength = 125
		var angle = self.rotation
		apply_central_impulse(Vector2(cos(angle), sin(angle)) * impulse_strength)
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("bark")
