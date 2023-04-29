extends Node2D

@onready var laika = $Laika
@onready var gg = $gg
@onready var ray = $Laika/RayCast2D
@onready var line = $Line2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	line.set_point_position(0,laika.position)
	gg.global_position = laika.global_position
	ray.look_at(get_global_mouse_position())
	if Input.is_action_pressed("click"):
		if ray.is_colliding():
			line.set_point_position(1, ray.get_collision_point())
			var thingtostick = ray.get_collider()
			var distancelength = ray.get_collision_point().distance_to(laika.global_position)
			
			gg.length = distancelength
			gg.global_rotation_degrees = ray.global_rotation_degrees - 90
			gg.rest_length = distancelength * 0.55
			
			gg.node_b = thingtostick.get_path()
			
	else:
		gg.node_b = gg.node_a
		line.set_point_position(1, laika.global_position)
		
		
