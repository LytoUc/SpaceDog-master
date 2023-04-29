extends Node2D

var rng = RandomNumberGenerator.new()
var rat = load("res://Elements/MeteoritoChikito.tscn")
var st = "Orbit"
@export var imagen : Resource
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = imagen
	var mouse_cant = rng.randi_range(2,4)
	for m in range(1,mouse_cant):
		var rat_instance = rat.instantiate()
		st += str(m) + "/PathFollow2D"
		get_node(st).add_child(rat_instance)
		st = "Orbit"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	const move_speed1 := 1
	const move_speed2 := 0.5
	const move_speed3 := 0.25
	$Orbit1/PathFollow2D.progress += move_speed1 + delta 
	$Orbit2/PathFollow2D.progress += move_speed2 + delta 
	$Orbit3/PathFollow2D.progress += move_speed3 + delta 
