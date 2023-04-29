extends RigidBody3D

var jump_initial_impulse := 5
var rotation_speed := 1
var move_speed := 3

var _last_strong_direction := Vector3.FORWARD
var local_gravity := Vector3.DOWN

var _move_direction := Vector3.ZERO

@onready var _model = $capsula

func _ready():
	pass

func _integrate_forces(state):
	local_gravity = state.total_gravity.normalized()
	print("flag")
	if _move_direction.length() > 0.2:
		_last_strong_direction = _move_direction.normalized()
	
	_move_direction = _get_model_oriented_input()
	_orient_character_to_direction(_last_strong_direction, state.step)
	
	if is_jumping():
		#_model.jump()
		
		apply_central_impulse(-local_gravity*jump_initial_impulse)
		
	if is_on_floor(state):
		apply_central_force(_move_direction*move_speed)

func _get_model_oriented_input() -> Vector3:
	var input_left_right := (
		Input.get_action_strength("left") - Input.get_action_strength("right")
	)
	var input_forward := Input.get_action_strength("up")
	
	var raw_input = Vector2(input_left_right, input_forward)
	
	var input := Vector3.ZERO
	
	input.x = raw_input.x * sqrt(1.0 -  raw_input.y * raw_input.y/2.0)
	input.z = raw_input.y * sqrt(1.0 -  raw_input.x * raw_input.x/2.0)
	
	input = _model.transform.basis * input
	return input

func _orient_character_to_direction(direction: Vector3, delta: float) -> void:
	var left_axis := -local_gravity.cross(direction)
	var rotation_basis := Basis(left_axis, -local_gravity, direction).orthonormalized()
	_model.transform.basis = Basis(_model.transform.basis.get_rotation_quaternion().slerp(
		rotation_basis, delta*rotation_speed
	))

func  is_jumping() -> bool:
	if Input.is_action_pressed("space"):
		return true
	else:
		return false
	
func is_on_floor(state: PhysicsDirectBodyState3D) -> bool:
	for contact in state.get_contact_count():
		var contact_normal = state.get_contact_local_normal(contact)
		if contact_normal.dot(-local_gravity) > 0.5:
			return true
	return false
