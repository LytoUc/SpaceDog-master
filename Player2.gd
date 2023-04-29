extends CharacterBody3D


const SPEED = 10.0
const GRAVITY = 8.0
const SPACE = 0
const JUMP_VELOCITY = 10
const PROPULSION = 80

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var external_dir

@onready var planet : Node3D = get_parent().get_node("Sun/Planet1")
@onready var camera : Node3D = get_parent().get_node("Gimball/InnerGimball")


func _physics_process(delta):
	
	var direction_from_planet = position - planet.global_position
	external_dir = direction_from_planet
	if(motion_mode != MOTION_MODE_FLOATING):
		up_direction = external_dir
	if not is_on_floor():
		velocity -= gravity * delta * direction_from_planet.normalized() * GRAVITY
		if Input.is_action_just_pressed("click"):
			velocity = PROPULSION * direction_from_planet.normalized()
	# Handle Jump.
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity = JUMP_VELOCITY * direction_from_planet.normalized()
		
	
	if is_on_floor():
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir : Vector2 = Input.get_vector("left", "right", "up", "down")
		var direction_global = camera.basis * Vector3(input_dir.x, -input_dir.y, 0)
		
		var direction_local = self.basis.inverse() * direction_global
		direction_local.y = 0
		
		var desired_forward = basis * Vector3.FORWARD
		
		var direction = basis * direction_local
		direction = direction.normalized()
		
		if direction.length() > 0.01:
			desired_forward = direction
		
		var desired_up = direction_from_planet.normalized()
		var desired_right = desired_forward.cross(desired_up)
		
		var new_orientation = Basis(desired_right, desired_up, -desired_forward)
		
		basis = new_orientation.orthonormalized()

		velocity = lerp(velocity, direction * SPEED, delta * 5)
		
	elif not is_on_wall():
		var input_dir : Vector2 = Input.get_vector("left", "right", "up", "down")
		var direction_global = camera.basis * Vector3(input_dir.x, -input_dir.y, 0)
		var direction = direction_global.normalized()
		velocity = lerp(velocity, direction*SPEED, delta*5 )
	move_and_slide()

func planet_area_entered(obj : Node3D):
	motion_mode = MOTION_MODE_GROUNDED
	up_direction = external_dir
	print("Entered")
	planet = obj

func planet_area_exited():
	motion_mode = MOTION_MODE_FLOATING
	#planet = self
	print("Exited")
