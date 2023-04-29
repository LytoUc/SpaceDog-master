extends StaticBody3D

@onready var pathA = $Orbita1/PathFollow3D
@onready var pathB = $Orbita2/PathFollow3D
@onready var pathC = $Orbita3/PathFollow3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	const move_speedA := 3.0
	const move_speedB := 4.0
	const move_speedC := 5.0
	pathA.progress += move_speedA * delta
	pathB.progress += move_speedB * delta
	pathC.progress += move_speedC * delta
