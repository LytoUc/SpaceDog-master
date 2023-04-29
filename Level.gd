extends Node2D

@onready var laika = $Laika
@onready var gg = $gg
@onready var ray = $Laika/RayCast2D
@onready var line = $Line2D
var rng = RandomNumberGenerator.new()
var rng2 = RandomNumberGenerator.new()
var rng3 = RandomNumberGenerator.new()

func pos_meteorito(nodo : StaticBody2D,num : int):
	var rang_l = 300*(num-3) 
	var rang_r = 300*(num-2)
	nodo.global_position.x = rng2.randi_range(-rang_l,rang_l)
	nodo.global_position.y = rng3.randi_range(-300,300)
# Called when the node enters the scene tree for the first time.
func _ready():
	laika.global_position.x = -1250
	laika.global_position.y = 0
	pos_meteorito($Meteorito, 0)
	pos_meteorito($Meteorito2, 1)
	pos_meteorito($Meteorito3, 5)
	pos_meteorito($Meteorito4, 6)
	pos_meteorito($Meteorito5, 7)
	$Planet.global_position.x = rng.randi_range(-750,750)
	$Planet.global_position.y = rng.randi_range(-200,200)

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
		
		
