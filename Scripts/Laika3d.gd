extends RigidBody3D
var gravity_direction = Vector3()
var move_force = 3
var jump_force = 2

var planet_name = "space"

var _move_direction = Vector3()
func _ready():
	_calc_gravity_direction("Planet2")

func _process(delta):
	
	if planet_name != "space":
		_calc_gravity_direction(planet_name)
	
func _integrate_forces(state):
	_move_direction = _get_model_oriented_input()
	_walk_around_planet(state)
	apply_central_force(global_transform.basis*_move_direction)
	
func _calc_gravity_direction(planet):
	gravity_direction = (get_parent().get_node("Planet2").global_transform.origin - global_transform.origin).normalized()
	
func _walk_around_planet(state):
	state.transform.basis.y = -gravity_direction

func _get_model_oriented_input() -> Vector3:
	var input_left_right := (
		Input.get_action_strength("left") - Input.get_action_strength("right")
	)
	var input_forward := Input.get_action_strength("up")
	
	var raw_input = Vector2(input_left_right, input_forward)
	
	var input := Vector3.ZERO
	
	input.x = raw_input.x * sqrt(1.0 -  raw_input.y * raw_input.y/2.0)
	input.z = raw_input.y * sqrt(1.0 -  raw_input.x * raw_input.x/2.0)
	
	return input
	
"""
func _move():
	if Input.is_action_pressed("up"):
		apply_central_force(move_force*global_transform.basis.z)
	if Input.is_action_pressed("down"):
		apply_central_force(move_force*-global_transform.basis.z)
	if Input.is_action_pressed("right"):
		apply_central_force(move_force*global_transform.basis.x)
	if Input.is_action_pressed("left"):
		apply_central_force(move_force*-global_transform.basis.x)
		
	if Input.is_action_pressed("space"):
		apply_impulse(Vector3.UP, jump_force*global_transform.basis.y)
"""

func set_planet_name(n):
	print("Changing planet to: " + n)
	planet_name = n
