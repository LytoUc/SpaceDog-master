extends CharacterBody2D
class_name Player


const SPEED = 95
const JUMP_VELOCITY = -350

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D
@onready var coinslabel := $PlayerGUI/HBoxContainer/coinsLabel

func _ready():
	Global.player = self

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		"motion_offset"
		if(velocity.y >= 0):
			animated_sprite.animation = "fall"
		else:
			animated_sprite.animation = "jump"
	else:
		if(velocity.x == 0):
			animated_sprite.animation = "idle"
		else:
			animated_sprite.animation = "walk"

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		
		if(velocity.x < 0):
			animated_sprite.flip_h = true
		elif(velocity.x > 0):
			animated_sprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_released("space"):
		velocity.y += 100

	move_and_slide()
	
func actualizaInterfazCoins():
	coinslabel.text = str(Global.coins)
