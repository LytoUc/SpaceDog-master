extends CharacterBody2D

@export var speed = 100


var player_pos 
var target_pos
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = get_parent().get_parent().get_node("Player")


func _physics_process(delta):
	player_pos = player.position 
	target_pos = (player_pos - position).normalized()
	velocity.x = target_pos.x * speed
	velocity.y += gravity * delta
	
	move_and_slide()
