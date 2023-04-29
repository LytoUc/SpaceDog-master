extends Node2D
@onready var orbit1 = $Orbit1/PathFollow2D
@onready var orbit2 = $Orbit2/PathFollow2D

var SPEED = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	orbit1.progress += 1*delta*SPEED
	orbit2.progress += 1*delta*SPEED*0.5
